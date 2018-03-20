package models

import "github.com/jinzhu/gorm"

type UserFollowing struct {
	gorm.Model
	UserID          uint64
	Version         string
	FollowingUserID uint64
}

func (f *UserFollowing) Create() (err error) {
	var isExist bool
	if isExist, err = f.IsExist(); err != nil {
		return
	} else if isExist {
		err = f.Update()
	} else {
		err = engine.Create(f).Error
	}
	return
}

func (f *UserFollowing) IsExist() (isExist bool, err error) {
	var count int
	if err = engine.Model(new(UserFollowing)).
		Where(UserFollowing{UserID: f.UserID, FollowingUserID: f.FollowingUserID}).
		Count(&count).Error; err != nil {
		return
	}
	if count != 0 {
		isExist = true
		return
	}
	return
}

func (f *UserFollowing) Update() (err error) {
	return
}
