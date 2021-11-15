from typing import Optional
from pydantic import BaseModel

class RegisterMember(BaseModel):
    nama: str
    email: str
    password: str