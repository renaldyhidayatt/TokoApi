from typing import Optional
from sqlmodel import SQLModel, Field, Relationship
from .member import Member


class MemberToken(SQLModel, table=True):
    id: Optional[int] = Field(primary_key=True, index=True)
    member_id: Optional[int] = Field(default=None, foreign_key="member.id")
    member: Optional[Member] = Relationship(back_populates="member")
    auth_key: str
