import Router from "@koa/router";
import userRouter from "./user_routes";

const router = new Router({
    prefix: "/api"
});

router.use("/user", userRouter.routes());

export default router;