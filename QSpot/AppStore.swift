import Foundation

final class AppStore: ObservableObject {
    @Published var tab = 0
    @Published var favorites: Set<String> = ["1"]
    @Published var filter = "Tutti"
    @Published var query = ""

    let people: [Person] = [
        .init(id:"1", name:"Luca", age:24, distance:"300 m", image:"p1", hero:"hero1", bio:"Viaggi, mare e serate spontanee. Cerco persone vere, senza pose.", online:true, verified:true, interests:["Viaggi","Palestra","Musica"]),
        .init(id:"2", name:"Marco", age:28, distance:"450 m", image:"p2", hero:"p2", bio:"Diretto, ironico e sempre pronto a conoscere qualcuno di interessante.", online:true, verified:true, interests:["Cinema","Fitness","Cucina"]),
        .init(id:"3", name:"Andrea", age:26, distance:"600 m", image:"p3", hero:"p3", bio:"Fotografia, arte e conversazioni che durano più di cinque minuti.", online:true, verified:false, interests:["Foto","Arte","Caffè"]),
        .init(id:"4", name:"Matteo", age:31, distance:"1,2 km", image:"p4", hero:"hero2", bio:"Mare, concerti e zero complicazioni inutili.", online:false, verified:true, interests:["Mare","Concerti","Sport"]),
        .init(id:"5", name:"Gabriele", age:29, distance:"1,8 km", image:"p5", hero:"p5", bio:"Curioso, semplice, sempre in movimento.", online:true, verified:false, interests:["Weekend","Food","Podcast"]),
        .init(id:"6", name:"Daniele", age:27, distance:"2,1 km", image:"p6", hero:"p6", bio:"Cerco nuove conoscenze e belle energie.", online:true, verified:true, interests:["Design","Musica","Viaggi"])
    ]

    lazy var chats: [ChatRow] = [
        .init(person: people[0], preview:"Ciao! Come va?", time:"21:45", unread:2),
        .init(person: people[1], preview:"Domani sei libero?", time:"20:12", unread:1),
        .init(person: people[2], preview:"Ti va di vederci?", time:"19:08", unread:0),
        .init(person: people[3], preview:"Foto", time:"18:33", unread:0)
    ]

    var filtered: [Person] {
        people.filter { p in
            let q = query.isEmpty || p.name.localizedCaseInsensitiveContains(query)
            let f: Bool
            switch filter {
            case "Online": f = p.online
            case "Verificati": f = p.verified
            case "Vicini": f = ["1","2","3"].contains(p.id)
            default: f = true
            }
            return q && f
        }
    }

    func toggle(_ person: Person) {
        if favorites.contains(person.id) { favorites.remove(person.id) }
        else { favorites.insert(person.id) }
    }
}
