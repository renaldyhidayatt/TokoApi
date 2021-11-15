from typing import TYPE_CHECKING, Optional, List
from sqlmodel.main import SQLModel, Relationship, Field

if TYPE_CHECKING:
    from .member_token import MemberToken


class Member(SQLModel, table=True):
    id: Optional[int] = Field(primary_key=True, index=True)
    nama: str
    email: str
    password: str
    member: List["MemberToken"] = Relationship(back_populates="member")
