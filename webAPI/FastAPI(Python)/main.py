from fastapi import FastAPI

app = FastAPI()

@app.get("/products")
def get_product():
    return {"message":"商品一覧です"}