from fastapi import Depends
from config.database import engine

from models.member import Member
from sqlalchemy.orm import Session
from dto.memberschema import RegisterMember
from config.hashing import Hashing
from sqlmodel import Session


class MemberServices:
    def get_user(email: str):
        db = Session(engine)
        return db.query(Member).filter(Member.email == email).first()

    def get_all():
        db = Session(engine)
        return db.query(Member).all()

    def create_user(user: RegisterMember):
        db = Session(engine)
        hashed_password = Hashing.bcrypt(user.password)
        new_user = Member(
            nama=user.nama,
            email=user.email,
            password=hashed_password,
        )
        db.add(new_user)
        db.commit()
        db.refresh(new_user)
        return new_user

    def get_userid(id: int):
        db = Session(engine)
        db_id = db.query(Member).filter(Member.id == id).first()

        return db_id

    def update_user(id: int, request: RegisterMember):
        db = Session(engine)
        db_id = db.query(Member).filter(Member.id == id).first()

        db_id.nama = request.nama
        db_id.email = request.email
        db_id.password = request.password

        return db_id

    def deleteUser(id: int):
        db = Session(engine)
        db_id = db.query(Member).filter(Member.id == id).first()

        db.delete(db_id)

        db.commit()

        return "Delete"
