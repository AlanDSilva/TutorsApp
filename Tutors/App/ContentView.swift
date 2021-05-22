//
//  ContentView.swift
//  Tutors
//
//  Created by Alan on 20.5.2021.
//

import SwiftUI
import FirebaseStorage

struct ContentView: View {
    //MARK: - properties
    @State var showSheet = false
    @State var showImagePicker = false
    
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @State var image: UIImage?
    @State var download_image: UIImage?
    
    //MARK: - body
    var body: some View {
        VStack {
            HStack {
                if(image != nil) {
                    Image(uiImage: image!)
                        .resizable()
                        .scaledToFit()
                } else {
                    Image(systemName: "timelapse")
                }
                Spacer()
                if(download_image != nil) {
                    Image(uiImage: download_image!)
                        .resizable()
                        .scaledToFit()
                } else {
                    Image(systemName: "timelapse")
                }
                
            }//: hstack
            .padding()
            .onAppear(perform: {
                Storage.storage().reference().child("temp").getData(maxSize: 5 * 1024 * 1024) { data, err in
                    if let err = err {
                        print("an error has occurred - \(err.localizedDescription)")
                    } else {
                        if let imageData = data{
                            download_image = UIImage(data: imageData)
                        } else {
                            print("couldn't unwrap image data")
                        }
                    }
                }
            })
            
            
            // Picks image
            Button(action: {
                showSheet = true
            }, label: {
                Image(systemName: "plus.circle.fill")
                    .font(.title)
            })//: button
            .actionSheet(isPresented: $showSheet, content: {
                ActionSheet(title: Text("Add a picture"), message: nil, buttons: [
                    //button1
                    .default(Text("Camera"), action: {
                        showImagePicker = true
                        sourceType = .camera
                    }),
                    
                    //button2
                    .default(Text("Photo Library"), action: {
                        showImagePicker = true
                        sourceType = .photoLibrary
                    }),
                    
                    //button3
                    .cancel()
                ])
            })
            .sheet(isPresented: $showImagePicker, content: {
                imagePicker(image: $image, showImagePicker: $showImagePicker, sourceType: sourceType)
            })
            
            //Uploads image
            Button(action: {
                if let upload_image = image{
                    uploadImage(image: upload_image)
                } else {
                    print("couldn't upload image - no image present")
                }
                
            }, label: {
                Text("Upload Image")
            })
            
            //Downloads image
            Button(action: {
                Storage.storage().reference().child("temp").getData(maxSize: 5 * 1024 * 1024) { data, err in
                    if let err = err {
                        print("an error has occurred - \(err.localizedDescription)")
                    } else {
                        if let imageData = data{
                            download_image = UIImage(data: imageData)
                        } else {
                            print("couldn't unwrap image data")
                        }
                        
                    }
                }
                
                
            }, label: {
                Text("Download Image")
            })
        }
    }
}

func uploadImage(image: UIImage) {
    if let imageData = image.jpegData(compressionQuality: 0.6) {
        let storage = Storage.storage()
        storage.reference().child("temp").putData(imageData, metadata: nil) { _, err in
            if let err = err {
                print("an error has occurred - \(err.localizedDescription)")
            } else {
                print("image uploaded succesfully")
            }
        }
    } else {
        print("Couldn't unwrapp/cast image to data")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
