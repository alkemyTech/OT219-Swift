//
//  ProgramsViewModel.swift
//  SwiftTemplate
//
//  Created by Adriancys Jesus Villegas Toro on 2/6/22.
//

import Foundation

struct ProgramsViewModel{

    var programs : [ProgramsCollectionViewCellViewModel] = [
        ProgramsCollectionViewCellViewModel(title: "program A", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse dictum, nisi nec accumsan dictum, erat ante consectetur urna, sit amet rutrum nisl mauris eget mauris. Aliquam blandit magna in dui varius, ac aliquam ex dapibus. Sed fringilla a nisi ut porta. Proin eleifend lobortis dui quis faucibus. Curabitur dignissim ultricies efficitur. Pellentesque condimentum purus sed ligula lacinia, eu sollicitudin erat vulputate. Aenean tincidunt vehicula mattis. Sed quis tortor sit amet elit placerat condimentum. Donec gravida magna id mi bibendum cursus.", nameImage: "logo-Alkemy"),
        ProgramsCollectionViewCellViewModel(title: "program B",description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse dictum, nisi nec accumsan dictum, erat ante consectetur urna, sit amet rutrum nisl mauris eget mauris. Aliquam blandit magna in dui varius, ac aliquam ex dapibus. Sed fringilla a nisi ut porta. Proin eleifend lobortis dui quis faucibus. Curabitur dignissim ultricies efficitur. Pellentesque condimentum purus sed ligula lacinia, eu sollicitudin erat vulputate. Aenean tincidunt vehicula mattis. Sed quis tortor sit amet elit placerat condimentum. Donec gravida magna id mi bibendum cursus.", nameImage: "LOGO-SOMOS MAS"),
        ProgramsCollectionViewCellViewModel(title: "program C",description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse dictum, nisi nec accumsan dictum, erat ante consectetur urna, sit amet rutrum nisl mauris eget mauris. Aliquam blandit magna in dui varius, ac aliquam ex dapibus. Sed fringilla a nisi ut porta. Proin eleifend lobortis dui quis faucibus. Curabitur dignissim ultricies efficitur. Pellentesque condimentum purus sed ligula lacinia, eu sollicitudin erat vulputate. Aenean tincidunt vehicula mattis. Sed quis tortor sit amet elit placerat condimentum. Donec gravida magna id mi bibendum cursus.", nameImage: "logo-Alkemy"),
        ProgramsCollectionViewCellViewModel(title: "program D", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse dictum, nisi nec accumsan dictum, erat ante consectetur urna, sit amet rutrum nisl mauris eget mauris. Aliquam blandit magna in dui varius, ac aliquam ex dapibus. Sed fringilla a nisi ut porta. Proin eleifend lobortis dui quis faucibus. Curabitur dignissim ultricies efficitur. Pellentesque condimentum purus sed ligula lacinia, eu sollicitudin erat vulputate. Aenean tincidunt vehicula mattis. Sed quis tortor sit amet elit placerat condimentum. Donec gravida magna id mi bibendum cursus.", nameImage: "LOGO-SOMOS MAS"),
        ProgramsCollectionViewCellViewModel(title: "program E",description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse dictum, nisi nec accumsan dictum, erat ante consectetur urna, sit amet rutrum nisl mauris eget mauris. Aliquam blandit magna in dui varius, ac aliquam ex dapibus. Sed fringilla a nisi ut porta. Proin eleifend lobortis dui quis faucibus. Curabitur dignissim ultricies efficitur. Pellentesque condimentum purus sed ligula lacinia, eu sollicitudin erat vulputate. Aenean tincidunt vehicula mattis. Sed quis tortor sit amet elit placerat condimentum. Donec gravida magna id mi bibendum cursus.", nameImage: "logo-Alkemy")
    ]
    
    
    func getProgramCount() -> Int{
        programs.count
    }
    
    func getProgram(index: Int) -> ProgramsCollectionViewCellViewModel{
        programs[index]
    }
    
}
