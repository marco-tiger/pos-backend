import dotenv from "dotenv";

class Env
{
    private static instance: Env;

    public readonly port: number;
    
    private constructor() {
        if (process.env.NODE_ENV !== "production")
        {
            dotenv.config();
        }

        this.port = Number(this.ValidateEnv(process.env.PORT));
    }

    public static setup()
    {
        if (!Env.instance)
        {
            Env.instance = new Env();
        }

        return Env.instance;
    }

    private ValidateEnv(env: string | undefined)
    {
        if (env == null)
        {
            throw new Error("Environment variable not found");
        }

        return env;
    }
}

export default Env;