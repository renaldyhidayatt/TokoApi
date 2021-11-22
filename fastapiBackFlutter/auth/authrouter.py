from fastapi import APIRouter, Depends, status, HTTPException
from fastapi.security import OAuth2PasswordRequestForm
from config.token import create_access_token
from models.member_token import MemberToken


from models.member import Member
from config.database import engine
from config.hashing import Hashing
from sqlmodel import Session

router = APIRouter(tags=["Authentication"])


@router.post("/login")
def login(
    request: OAuth2PasswordRequestForm = Depends(),
):
    db = Session(engine)
    user = db.query(Member).filter(Member.email == request.username).first()
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND, detail=f"Invalid Credentials"
        )
    if not Hashing.verify(user.password, request.password):
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND, detail=f"Incorrect password"
        )

    access_token = create_access_token(data={"sub": user.email})
    member_token = MemberToken(auth_key=access_token)
    member_token.member = user
    db.commit()

    response = {
        "id": user.id,
        "name": user.nama,
        "email": user.email,
        "jwtToken": access_token,
    }
    return response
