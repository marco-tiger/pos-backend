import Koa from "koa";
import { bodyParser } from "@koa/bodyparser";
import router from "./routes";
import Env from "./config/env";

const app = new Koa();

app.use(bodyParser());

app.use(router.routes());

app.use(router.allowedMethods());

const env = Env.get();

app.listen(env.port, () => {
    console.log(`Server running on port ${env.port}`);
});