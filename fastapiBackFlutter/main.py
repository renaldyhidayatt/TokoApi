import uvicorn
from fastapi import FastAPI
from members import membersrouter
from auth import authrouter
from product import productrouter
from config.database import create_table

app = FastAPI()


@app.on_event("startup")
async def coba():
    create_table()
    print("connect")


@app.get("/")
def hello():
    return "Hello"


app.include_router(authrouter.router)
app.include_router(membersrouter.router)
app.include_router(productrouter.router)

if __name__ == "__main__":
    uvicorn.run("main:app", reload=True)
