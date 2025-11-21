//
//  BasicActionDisplayView.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/25/25.
//
import SwiftUI

struct BasicActionDisplayView: View {
    @Environment(AppData.self) private var appData: AppData
    @State var basicActionElements: [BasicActionElement] = []
    // Optional, set to filter BasicActionElements by their group name
    @State var groupName: String = ""
    // Optional, set to specify the action in the current phase rather than determining it from appData
    @State var actionRef: String = ""
    
    var body: some View {
        VStack() {
            ForEach(basicActionElements) { actionElement in
                let contentString = RenderContent(actionElement: actionElement)
                switch actionElement.elementType {
                case .Header:
                    Text(contentString).font(.title).padding()
                case .Header2:
                    Text(contentString).font(.title2).padding()
                case .Header3:
                    Text(contentString).font(.title3).padding()
                case .Paragraph:
                    VStack{
                        Text(contentString)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                case .BulletPoint:
                    VStack {
                        BasicActionBulletPoint(content: contentString)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                case .CustomButton:
                    Button(action: {
                        appData.customActionButtonListener = actionElement.customButtonListener
                    }, label: {
                        Text(contentString)
                    })
                    .padding()
                default:
                    Text("unknown Action Elelement Type!")
                }
            }
        }
        .onAppear() {
            RefreshActionElements()
        }
        .onChange(of: appData.goToNextAction) {
            RefreshActionElements()
        }
    }
    
    
    private func RenderContent(actionElement: BasicActionElement) -> LocalizedStringKey {
        var content = actionElement.content
        for replaceRule in appData.valueReplacements {
            content = content.replacingOccurrences(of: replaceRule.needle, with: replaceRule.value)
        }
        return LocalizedStringKey(content)
    }
    
    
    private func RefreshActionElements() {
        var allActionElements: [BasicActionElement] = []
        if  actionRef != "" {
            for phaseAction in appData.GetCurrentPhase().getPhaseActions() {
                if phaseAction.getActionRef() == actionRef {
                    allActionElements = phaseAction.getBasicActionElements()
                }
            }
        } else {
            allActionElements = appData.GetCurrentAction().getBasicActionElements()
        }
        
        if groupName != "" {
            basicActionElements = PhaseHelperMethods.FilterBasicActionElementsByGroupName(groupName: groupName, actionElements: allActionElements)
        } else {
            basicActionElements = allActionElements
        }
    }
}


struct BasicActionBulletPoint: View {
    @State var content: LocalizedStringKey
    var body: some View {
        HStack(alignment: .top) {
            Text("•")
            Text(content)
        }
    }
}


#Preview (traits: .modifier(CDMDPlayerPreviewTrait())){
    BasicActionDisplayView(actionRef: "attack")
}
