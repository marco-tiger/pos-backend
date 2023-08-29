import Router from "@koa/router";
import * as controllers from "../controllers/user_controller";

const userRouter = new Router();

userRouter.get("/authentication", controllers.userAuthController);

export default userRouter;