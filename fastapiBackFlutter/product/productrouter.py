from fastapi import APIRouter

from dto.productschema import ProductSchema
from .productservice import ProductService


router = APIRouter(prefix="/products", tags=["Product"])


@router.get("/")
def getAll():
    return ProductService.getall()


@router.post("/create")
def createProduct(request: ProductSchema):
    return ProductService.createProduct(request=request)


@router.put("/update/{id}")
def updateProduct(id: int, request: ProductSchema):
    return ProductService.updateProduct(id=id, request=request)


@router.delete("/{id}")
def deleteProduct(id: int):
    return ProductService.deleteProduct(id=id)
