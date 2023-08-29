import { Middleware } from "@koa/router";

const userAuthController: Middleware = function (ctx)
{
    ctx.body = "Hello world!";
}

export {
    userAuthController
};