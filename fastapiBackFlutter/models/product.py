from sqlalchemy.sql.expression import table
from sqlmodel import SQLModel, Field

class Product(SQLModel, table=True):
    id: int = Field(primary_key=True, index=True)
    kode_product: int
    nama_product: str
    harga_product: int