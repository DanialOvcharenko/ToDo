//
//  ToDoList.swift
//  ScrolingPagesTest
//
//  Created by Mac on 24.10.2022.
//

import SwiftUI

struct ListView: View {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    @State private var showAlert: Bool = false
    @State private var showSheet: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                
                ZStack {
                    if listViewModel.items.isEmpty {
                        NoItemsView()
                    } else if listViewModel.items.isEmpty == false && listViewModel.ResultArr.isEmpty {
                        NoItemsOfTypeView()
                    } else {
                        List {
                            ForEach(listViewModel.ResultArr) { item in
                                ListRowView(item: item)
                                    .onTapGesture {
                                        withAnimation(.linear) {
                                            listViewModel.updateItem(item: item)
                                        }
                                    }
                            }
                            .onDelete(perform: listViewModel.deleteItem)
                            .onMove(perform: listViewModel.moveItem)
                        }
                    }
                    
                }
                
                .listStyle(PlainListStyle())
                .navigationTitle("Todo List 📝")
                // control command space     ^
                .navigationBarItems(
                    leading: EditButton(),
                    trailing: NavigationLink("Add", destination: AddView())
                )
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showAlert.toggle()
                        } label: {
                            Label("Delete All", systemImage: "x.square")
                                .foregroundColor(Color("RtoO"))
                        }
                        .alert(isPresented: $showAlert, content: {
                                Alert(
                                    title: Text("Shure? 🤨"),
                                    message: Text("Do you realy want to delete all items?"),
                                    primaryButton: .default(Text("Delete 🧽")) {
                                        listViewModel.deleteAll()
                                    },
                                    secondaryButton: .cancel(Text("No, thanks")))
                        })
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showSheet.toggle()
                        } label: {
                            Label("Instruction", systemImage: "questionmark.circle")
                        }
                        .sheet(isPresented: $showSheet) {
                            Sheet()
                        }
                    }
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Menu {
                            Button {
                                listViewModel.updateResultArray()
                            } label: {
                                Label("Show all", systemImage: "arrow.uturn.backward.circle.badge.ellipsis")
                            }

                            Menu {
                                Button {
                                    listViewModel.filterIsNotCompleted()
                                } label: {
                                    Label("Is not completed", systemImage: "circle")
                                }
                                Button {
                                    listViewModel.filterIsCompleted()
                                } label: {
                                    Label("Is completed", systemImage: "checkmark.circle.fill")
                                }
                            } label: {
                                Label("ByStatus", systemImage: "app.badge.checkmark.fill")
                            }

                        } label: {
                            Image(systemName: "slider.horizontal.3")
                                .resizable()
                                .frame(width: 37, height: 32)
                                .foregroundColor(Color("RtoO"))

                        }
                        Spacer()
                            .frame(width: 30)
                    }
                    Spacer()
                        .frame(height: 30)
                }
                
            }
        }
//        .accentColor(.red)
        .environmentObject(listViewModel)
    }
}




struct ToDoList_Previews: PreviewProvider {
    static var previews: some View {
            ListView()
    }
}


