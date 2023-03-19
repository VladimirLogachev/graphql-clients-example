import SwiftUI
import Foundation
import SwiftGraphQL
import SwiftGraphQLClient

struct Demo: Equatable {
    var int: Int
}

let demoSelection = Selection.Demo<Demo> {
    let int = try $0.int()
    return Demo(int: int)
}

let url = URL(string: "http://localhost:8088/api/graphql")!
let client = SwiftGraphQLClient.Client(request: URLRequest(url: url))

struct ContentView: View {
    @State private var stringResult: String = "?"
    
    var body: some View {
        VStack {
            Text("Result: \(stringResult)")
            Button("Run query") {
                let querySelection: Selection<Demo, Objects.Queries> = Selection.Queries<Demo> {
                    try $0.demo(selection: demoSelection)
                }
                let queryRequest = URLRequest(url: url).querying(querySelection)
                let task = URLSession.shared.dataTask(with: queryRequest) { data, response, error in
                    guard let result = try? data?.decode(querySelection) else {
                        stringResult = "error"
                        return
                    }
                    stringResult = "\(result.data.int)"
                }
                task.resume()
                
            }
            Button("Run mutation") {
                func increment(input: Demo) -> Selection.Mutations<Demo> {
                    Selection.Mutations<Demo> {
                        let x: InputObjects.DemoInputInput = InputObjects.DemoInputInput(int: input.int)
                        return try $0.increment(demoInput: x, selection: demoSelection)
                    }
                }
                let q: Selection<Demo, Objects.Mutations> = increment(input: Demo(int: 42))
                let mutationRequest = URLRequest(url: url).querying(q)
                let task = URLSession.shared.dataTask(with: mutationRequest) { data, response, error in
                    guard let result = try? data?.decode(q) else {
                        stringResult = "error"
                        return
                    }
                    stringResult = "\(result.data.int)"
                }
                task.resume()
                
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
