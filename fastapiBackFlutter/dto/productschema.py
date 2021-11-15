from pydantic import BaseModel


class ProductSchema(BaseModel):
    kode_product: int
    nama_product: str
    harga_product: int
