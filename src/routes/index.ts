import { Router, Request, Response } from "express";
import auth from "./auth";
import user from "./user";
import activity from "./activity";

const routes = Router();

routes.use("/auth", auth);
routes.use("/user", user);
routes.use("/activity", activity);

export default routes;