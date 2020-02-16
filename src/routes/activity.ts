import { Router } from "express";
import ActivityController from "../controllers/ActivityController";
import { checkJwt } from "../middlewares/checkJwt";
import { checkRole } from "../middlewares/checkRole";

const router = Router();

//Get all activities
router.get("/", [checkJwt, checkRole(["ADMIN"])], ActivityController.listAll);

// Get one activity
router.get(
  "/:id([0-9]+)",
  [checkJwt, checkRole(["USER","ADMIN"])],
  ActivityController.getOneById
);

// Get all user activity
router.get(
    "/usr/",
    [checkJwt, checkRole(["USER","ADMIN"])],
    ActivityController.getAllByUserId
  );

// Get all user activity with type filter 
router.get(
    "/type/:id([0-9]+)",
    [checkJwt, checkRole(["USER", "ADMIN"])],
    ActivityController.getAllByTypeAndUser
);

//Create a new activity
router.post("/", [checkJwt, checkRole(["USER","ADMIN"])], ActivityController.newActivity);

//Edit one activity - ADMIN
router.patch(
  "/:id([0-9]+)",
  [checkJwt, checkRole(["ADMIN"])],
  ActivityController.editActivity
);

//Edit one activity - USER
router.patch(
  "/usr/:id([0-9]+)",
  [checkJwt, checkRole(["ADMIN", "USER"])],
  ActivityController.editUserActivity
);

//Delete one activity
router.delete(
  "/:id([0-9]+)",
  [checkJwt, checkRole(["USER","ADMIN"])],
  ActivityController.deleteActivity
);

export default router;