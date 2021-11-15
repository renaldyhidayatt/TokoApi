from fastapi import APIRouter, Depends
from models.member import Member
from config.token import get_currentUser
from dto.memberschema import RegisterMember
from .memberservice import MemberServices

router = APIRouter(prefix="/members", tags=["Member"])


@router.post("/")
def createMember(user: RegisterMember):
    return MemberServices.create_user(user=user)


@router.get("/")
def getAll(current_user: Member = Depends(get_currentUser)):
    return MemberServices.get_all()


@router.put("/{id}")
def updateMember(
    id: int, request: RegisterMember, current_user: Member = Depends(get_currentUser)
):
    return MemberServices.update_user(id=id, request=request)


@router.delete("/{id}")
def deleteMember(id: int, current_user: Member = Depends(get_currentUser)):
    return MemberServices.deleteUser(id=id)
