import Koa from "koa";
import { bodyParser } from "@koa/bodyparser";
import router from "./routes";
import Env from "./config/env";

const env: Env = Env.setup();

const app = new Koa();

app.context.env = env;

app.use(bodyParser());

app.use(router.routes());

app.use(router.allowedMethods());

app.listen(env.port, () => {
    console.log(`Server running on port ${env.port}`);
});