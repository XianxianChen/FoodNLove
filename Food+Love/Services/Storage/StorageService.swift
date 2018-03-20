//  StorageService.swift
//  POSTR2.0
//  Created by Winston Maragh on 2/2/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.


import Foundation
import FirebaseStorage

class StorageService {
	private init(){
		storage = Storage.storage()
		storageRef = storage.reference()
		profileImagesRef = storageRef.child("profile images")
	}
	static let manager = StorageService()

	private var storage: Storage!
	private var storageRef: StorageReference!
	private var profileImagesRef: StorageReference!
    private var profileVideoRef: StorageReference!
    private var chatImagesRef: StorageReference!
    private var chatVideoRef: StorageReference!

	public func getStorageRef() -> StorageReference { return storageRef }
	public func getProfileImagesRef() -> StorageReference { return profileImagesRef }
    public func getProfileVideoRef() -> StorageReference { return profileVideoRef }
    public func getChatImagesRef() -> StorageReference { return chatImagesRef }
    public func getChatVideoRef() -> StorageReference { return chatVideoRef }
    
}
