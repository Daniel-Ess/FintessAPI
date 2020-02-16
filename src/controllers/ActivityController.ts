import { Request, Response } from "express";
import { getRepository } from "typeorm";
import { validate } from "class-validator";

import { Activity } from "../entity/Activity";

class ActivityController {

static listAll = async (req: Request, res: Response) => {
  //Get activities from database
  const activityRepo = getRepository(Activity);
  const activity = await activityRepo.find();

  //Send the activity object
  res.send(activity);
};

static getOneById = async (req: Request, res: Response) => {
  //Get the ID from the url
  const id: string = req.params.id;
  const userId = res.locals.jwtPayload.userId;
  const userRole = res.locals.jwtPayload.role;

  //Get the activity from database
  const activityRepo = getRepository(Activity);
  try {
    const activity = await activityRepo.findOneOrFail(id);
    //If not admin and user is not owner, return forbidden
    if (userRole != "ADMIN") {
      if (activity.userId != userId) {
        res.status(403).send("Forbidden");
        return;
      }
    }
    res.send(activity);
  } catch (error) {
    res.status(404).send("Activity not found");
  }
};

static getAllByUserId = async (req: Request, res: Response) => {
    //Get ID from JWT
    const idOfUser = res.locals.jwtPayload.userId;
  
    //Get the activity from database
    const activityRepo = getRepository(Activity);
    try {
      const activity = await activityRepo.find({
        where: [
            { userId: idOfUser }
          ]
      });
      res.send(activity);
    } catch (error) {
      res.status(404).send("Activity not found");
    }
  };


static getAllByTypeAndUser = async (req: Request, res: Response) => {
  const idOfUser = res.locals.jwtPayload.userId;
  const typeId: string = req.params.id;
  const activityRepo = getRepository(Activity);
  try {
    const activity = await activityRepo.find({
      where: [
          { userId: idOfUser,
            type: typeId }
        ]
    });
    res.send(activity);
  } catch (error) {
    res.status(404).send("Activity not found");
  }
}

static newActivity = async (req: Request, res: Response) => {
  //Get parameters from the body
  let { type, description, duration, latitude, longtitude } = req.body;
  const user = res.locals.jwtPayload.userId;
  let activity = new Activity();
  activity.type = type;
  activity.userId = user;
  activity.description = description;
  activity.duration = duration;
  activity.latitude = latitude;
  activity.longtitude = longtitude;
  activity.name = ActivityController.getActivityNameBasedOnType(type);
 
  //Validade if the parameters are ok
  const errors = await validate(activity);
  if (errors.length > 0) {
    res.status(400).send(errors);
    return;
  }


  const activityRepo = getRepository(Activity);
  try {
    await activityRepo.save(activity);
  } catch (e) {
    res.status(409).send(e);
    return;
  }

  //If all ok, send 201 response
  res.status(201).send("Activity created");
};


static editActivity = async (req: Request, res: Response) => {
  //Get the ID from the url
  const id = req.params.id;

  //Get values from the body
  const { type, description, duration, latitude, longtitude } = req.body;


  const activityRepo = getRepository(Activity);
  let activity;

  try {
    activity = await activityRepo.findOneOrFail(id);
  } catch (error) {
    //If not found, send a 404 response
    res.status(404).send("Activity not found");
    return;
  }

  activity.type = type;
  activity.description = description;
  activity.duration = duration;
  activity.latitude = latitude;
  activity.longtitude = longtitude;
  activity.name = ActivityController.getActivityNameBasedOnType(type);

  const errors = await validate(activity);
  if (errors.length > 0) {
    res.status(400).send(errors);
    return;
  }

  try {
    await activityRepo.save(activity);
  } catch (e) {
    res.status(409).send();
    return;
  }
  //After all send a 204 (no content, but accepted) response
  res.status(204).send();
};


// Edit activity owned by user
static editUserActivity = async (req: Request, res: Response) => {
    //Get the ID from the url
    const id = req.params.id;
    //Get the user id from token
    const idOfUser = res.locals.jwtPayload.userId;
    //Get values from the body
    const { type, description, duration, latitude, longtitude } = req.body;
  
  
    const activityRepo = getRepository(Activity);
    let activity;
  
    try {
      activity = await activityRepo.findOneOrFail(id);
    } catch (error) {
      //If not found, send a 404 response
      res.status(404).send("Activity not found");
      return;
    }
      //If user is not owner, send a 403 Forbidden response
    if (activity.userId !=  idOfUser) {
      res.status(403).send();
      return;
    }
  
    activity.type = type;
    activity.description = description;
    activity.duration = duration;
    activity.latitude = latitude;
    activity.longtitude = longtitude;
    activity.name = ActivityController.getActivityNameBasedOnType(type);

    const errors = await validate(activity);
    if (errors.length > 0) {
      res.status(400).send(errors);
      return;
    }
  
    try {
      await activityRepo.save(activity);
    } catch (e) {
      res.status(409).send();
      return;
    }
    //After all send a 204 (no content, but accepted) response
    res.status(204).send();
};


static deleteActivity = async (req: Request, res: Response) => {
  const userId = res.locals.jwtPayload.userId;
  const userRole = res.locals.jwtPayload.role;
  //Get the ID from the url
  const id = req.params.id;

  const activityRepo = getRepository(Activity);
  let activity: Activity;
  try {
    activity = await activityRepo.findOneOrFail(id);
  } catch (error) {
    res.status(404).send("Activity not found");
    return;
  }

  if (userRole != "ADMIN") {
    if (activity.userId != userId) {
      res.status(403).send("Forbidden");
      return;
    }
  }

  activityRepo.delete(id);

  //After all send a 204 (no content, but accepted) response
  res.status(204).send();
};

static getActivityNameBasedOnType(type) : string {
  let value;
  switch(type) {
    case "0":
      value = "Running";
      break;
    case "1":
      value = "Walking";
      break;
    case "2":
      value = "CrossFit";
      break;
    case "3":
      value = "Workout";
      break;
    case "4":
      value = "Yoga";
      break;
    default: 
      value = "Unknown";
      break;
  }
  return value;
}

};

export default ActivityController;