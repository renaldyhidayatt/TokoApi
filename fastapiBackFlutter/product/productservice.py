from dto.productschema import ProductSchema
from models.product import Product
from config.database import engine
from sqlmodel import Session


class ProductService:
    def getall():
        db = Session(engine)
        return db.query(Product).all()

    def createProduct(request: ProductSchema):
        db = Session(engine)
        db_product = Product(
            nama_product=request.nama_product,
            kode_product=request.kode_product,
            harga_product=request.harga_product,
        )

        db.add(db_product)
        db.commit()

        return db_product

    def updateProduct(id: int, request: ProductSchema):
        db = Session(engine)
        db_id = db.query(Product).filter(Product.id == id).first()

        db_id.nama_product = request.nama_product
        db_id.kode_product = request.kode_product
        db_id.harga_product = request.harga_product

        db.commit()

        return db_id

    def deleteProduct(id: int):
        db = Session(engine)
        db_delete = db.query(Product).filter(Product.id == id).first()

        db.delete(db_delete)
        db.commit()

        return "Delete"
