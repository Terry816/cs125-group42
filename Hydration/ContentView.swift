import SwiftUI
import MapKit
import CoreLocation

extension CLLocationCoordinate2D{
    static let water_dbh = CLLocationCoordinate2D(
        latitude: 33.64343506714631, longitude: -117.8420302482979)
    
    static let water_eng_tower = CLLocationCoordinate2D(
        latitude: 33.64471804347426, longitude: -117.84116510783429)
    
    static let water_langson_library = CLLocationCoordinate2D(
        latitude: 33.64710463844876, longitude: -117.84107162991442)
    
    static let water_sslh = CLLocationCoordinate2D(
        latitude: 33.64721711957846, longitude: -117.83978168943474)
    
    static let water_sst = CLLocationCoordinate2D(
        latitude: 33.646472577793034, longitude: -117.8402294469034)
    
    static let water_ssl = CLLocationCoordinate2D(
        latitude: 33.64596418641034, longitude: -117.83997664592668)
    
    static let water_steinhaus = CLLocationCoordinate2D(
        latitude: 33.6463134233031, longitude: -117.84469962983763)
    
    static let water_howard = CLLocationCoordinate2D(
        latitude: 33.645610383471606, longitude: -117.84466319975064)
    
    static let water_science_library = CLLocationCoordinate2D(
        latitude: 33.645908142215724, longitude: -117.8463091771569)
    
    static let water_student_center = CLLocationCoordinate2D(
        latitude: 33.649373517138784, longitude: -117.84252289745093)
    
    static let center_uci = CLLocationCoordinate2D(
        latitude: 33.648613, longitude: -117.842753)
    
}
struct ContentView: View {
    @State private var directions: [String] = []
    @State private var showDirections = false
    @State private var showMapView: Bool = false
    
    @State var camera: MapCameraPosition = .automatic
    @State private var isSatelliteView: Bool = false
    @StateObject var manager = LocationManager()
    @State private var showAlert_dbh = false
    @State private var showAlert_eng_tower = false
    @State private var showAlert_langson_library = false
    @State private var showAlert_sslh = false
    @State private var showAlert_sst = false
    @State private var showAlert_ssl = false
    @State private var showAlert_steinhaus = false
    @State private var showAlert_howard = false
    @State private var showAlert_science_library = false
    @State private var showAlert_student_center = false
    let hydration_icon = "hydration_icon"
    var body: some View {
        VStack {
            
            if showMapView{
                MapView(directions: $directions, camera: $camera)
                    .safeAreaInset(edge: .top){
                        HStack{
                            Spacer()
                            VStack {
                                Text("ZotWater")
                                    .foregroundColor(.white)
                                    .font(.system(size: 30, weight: .bold))
                                Spacer()
                            }
                            .frame(height: 50)
                            
                            Spacer()
                        }
                        .background(Color(red: 0, green: 0.3922, blue: 0.6431))
                    }
                    .safeAreaInset(edge: .bottom){
                        HStack{
                            Spacer()
                            Button{
                                camera = .region(MKCoordinateRegion(center:center_uci, latitudinalMeters: 150,
                                                                    longitudinalMeters: 150))
                                showMapView.toggle()
                            } label:{
                                Label("Locate Me", systemImage: "paperplane.circle.fill")
                            }
                            .foregroundColor(.white)
                            
                            Spacer()
                            Button{
                                isSatelliteView.toggle()
                            } label:{
                                Label("Toogle", systemImage: "square.fill")
                            }
                            .foregroundColor(.white)
                            
                            Spacer()
                                .buttonStyle(.borderedProminent)
                        }
                        .padding(.top)
                        .background(Color(red: 0, green: 0.3922, blue: 0.6431))
                    }
            }
            else {
                
                Map(position: $camera){
                    Annotation("DBH", coordinate: .water_dbh){
                        ZStack{
                            Image(hydration_icon)
                                .resizable()
                                .padding(5)
                                .frame(width: 35, height: 35)
                                .foregroundColor(.red)
                        }.onTapGesture {
                            showAlert_dbh = true
                        }.sheet(isPresented: $showAlert_dbh) {
                            CustomAlertView(showAlert: $showAlert_dbh, water_name: "water_dbh")
                        }
                    }
                    
                    Annotation("Engineering Tower", coordinate: .water_eng_tower){
                        ZStack{
                            Image(hydration_icon)
                                .resizable()
                                .padding(5)
                                .frame(width: 35, height: 35)
                                .foregroundColor(.red)
                        }.onTapGesture {
                            showAlert_eng_tower = true
                        }.sheet(isPresented: $showAlert_eng_tower) {
                            CustomAlertView(showAlert: $showAlert_eng_tower, water_name: "water_eng_tower")
                        }
                    }
                    
                    Annotation("Langson Library", coordinate: .water_langson_library){
                        ZStack{
                            Image(hydration_icon)
                                .resizable()
                                .padding(5)
                                .frame(width: 35, height: 35)
                                .foregroundColor(.red)
                        }.onTapGesture {
                            showAlert_langson_library = true
                        }.sheet(isPresented: $showAlert_langson_library) {
                            CustomAlertView(showAlert: $showAlert_langson_library, water_name: "water_langson_library")
                        }
                    }
                    
                    Annotation("SSLH", coordinate: .water_sslh){
                        ZStack{
                            Image(hydration_icon)
                                .resizable()
                                .padding(5)
                                .frame(width: 35, height: 35)
                                .foregroundColor(.red)
                        }.onTapGesture {
                            showAlert_sslh = true
                        }.sheet(isPresented: $showAlert_sslh) {
                            CustomAlertView(showAlert: $showAlert_sslh, water_name: "water_sslh")
                        }
                    }
                    
                    Annotation("SST", coordinate: .water_sst){
                        ZStack{
                            Image(hydration_icon)
                                .resizable()
                                .padding(5)
                                .frame(width: 35, height: 35)
                                .foregroundColor(.red)
                        }.onTapGesture {
                            showAlert_sst = true
                        }.sheet(isPresented: $showAlert_sst) {
                            CustomAlertView(showAlert: $showAlert_sst, water_name: "water_sst")
                        }
                    }
                    
                    Annotation("SSL", coordinate: .water_ssl){
                        ZStack{
                            Image(hydration_icon)
                                .resizable()
                                .padding(5)
                                .frame(width: 35, height: 35)
                                .foregroundColor(.red)
                        }.onTapGesture {
                            showAlert_ssl = true
                        }.sheet(isPresented: $showAlert_ssl) {
                            CustomAlertView(showAlert: $showAlert_ssl, water_name: "water_ssl")
                        }
                    }
                    
                    Annotation("Steinhaus Hall", coordinate: .water_steinhaus){
                        ZStack{
                            Image(hydration_icon)
                                .resizable()
                                .padding(5)
                                .frame(width: 35, height: 35)
                                .foregroundColor(.red)
                        }.onTapGesture {
                            showAlert_steinhaus = true
                        }.sheet(isPresented: $showAlert_steinhaus) {
                            CustomAlertView(showAlert: $showAlert_steinhaus, water_name: "water_steinhaus")
                        }
                    }
                    
                    Annotation("Howard Schneiderman", coordinate: .water_howard){
                        ZStack{
                            Image(hydration_icon)
                                .resizable()
                                .padding(5)
                                .frame(width: 35, height: 35)
                                .foregroundColor(.red)
                        }.onTapGesture {
                            showAlert_howard = true
                        }.sheet(isPresented: $showAlert_howard) {
                            CustomAlertView(showAlert: $showAlert_howard, water_name: "water_howard")
                        }
                    }
                    
                    Annotation("Science Library", coordinate: .water_science_library){
                        ZStack{
                            Image(hydration_icon)
                                .resizable()
                                .padding(5)
                                .frame(width: 35, height: 35)
                                .foregroundColor(.red)
                        }.onTapGesture {
                            showAlert_science_library = true
                        }.sheet(isPresented: $showAlert_science_library) {
                            CustomAlertView(showAlert: $showAlert_science_library, water_name: "water_science_library")
                        }
                    }
                    
                    Annotation("Student Center", coordinate: .water_student_center){
                        ZStack{
                            Image(hydration_icon)
                                .resizable()
                                .padding(5)
                                .frame(width: 35, height: 35)
                                .foregroundColor(.red)
                        }.onTapGesture {
                            showAlert_student_center = true
                        }.sheet(isPresented: $showAlert_student_center) {
                            CustomAlertView(showAlert: $showAlert_student_center, water_name: "water_student_center")
                        }
                    }
                    
                    
                    
                    Annotation("", coordinate: .center_uci){
                        ZStack{
                            Image(systemName: "circle.fill")
                                .resizable()
                                .padding(5)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.blue)
                        }
                    }
                    
                }
                .safeAreaInset(edge: .top){
                    HStack{
                        Spacer()
                        VStack {
                            Text("ZotWater")
                                .foregroundColor(.white)
                                .font(.system(size: 30, weight: .bold))
                            Spacer()
                        }
                        .frame(height: 50)
                        
                        Spacer()
                    }
                    .background(Color(red: 0, green: 0.3922, blue: 0.6431))
                }
                .safeAreaInset(edge: .bottom){
                    HStack{
                        Spacer()
                        
                        Button{
                            camera = .region(MKCoordinateRegion(center:center_uci, latitudinalMeters: 150,
                                                                longitudinalMeters: 150))
                            showMapView.toggle()
                        } label:{
                            Label("Locate Me", systemImage: "paperplane.circle.fill")
                        }
                        .foregroundColor(.white)
                        
                        Spacer()
                        Button{
                            isSatelliteView.toggle()
                        } label:{
                            Label("Toogle", systemImage: "square.fill")
                        }
                        .foregroundColor(.white)
                        
                        Spacer()
                            .buttonStyle(.borderedProminent)
                    }
                    .padding(.top)
                    .background(Color(red: 0, green: 0.3922, blue: 0.6431))
                }
                .mapStyle(isSatelliteView ? .imagery : .standard)
            }
        }
    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MapView: UIViewRepresentable {
    typealias UIViewType = MKMapView
    @Binding var directions: [String]
    @Binding var camera: MapCameraPosition
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator()
      }
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 33.648613, longitude: -117.842753),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        mapView.setRegion(region, animated: true)
        let p1 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 33.648613, longitude: -117.842753))
        
        // Boston
        let p2 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 33.64922407437117, longitude: -117.8424157076793))
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: p1)
        request.destination = MKMapItem(placemark: p2)
        request.transportType = .walking
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard let route = response?.routes.first else { return }
            mapView.addAnnotations([p1, p2])
            mapView.addOverlay(route.polyline)
            mapView.setVisibleMapRect(
                route.polyline.boundingMapRect,
                edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
                animated: true)
        }
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .systemBlue
            renderer.lineWidth = 5
            return renderer
        }
    }
}

struct CustomAlertView: View {
    @Binding var showAlert: Bool
    
    struct Bathroom {
        var description: String
        var image: String
    }
    
    var water_name: String
    var myDictionary: [String: Bathroom] = [
        "water_dbh": Bathroom(description: "DBH", image: "science_library_restroom"),
        "water_eng_tower": Bathroom(description: "Engineering Tower", image: "restroom2"),
        "water_langson_library": Bathroom(description: "Langson Library", image: "restroom3"),
        "water_sslh": Bathroom(description: "Social Science Lecture", image: "restroom4"),
        "water_sst": Bathroom(description: "Social Science Tower", image: "restroom5"),
        "water_ssl": Bathroom(description: "Social Science Lab", image: "restroom6"),
        "water_steinhaus": Bathroom(description: "Steinhaus Hall", image: "restroom2"),
        "water_howard": Bathroom(description: "Howard Schneiderman", image: "restroom2"),
        "water_science_library": Bathroom(description: "Science Library", image: "restroom2"),
        "water_student_center": Bathroom(description: "Student Center", image: "restroom2")
    ]

    var body: some View {
        VStack (
        )
        {
            HStack {
                Spacer()
                if let person = myDictionary[water_name] {
                    Text(person.description)
                        .foregroundColor(.white)
                        .font(.system(size: 28, weight: .bold))
                        .padding()
                }
                Spacer()
            }
            .frame(width: 400, height: 80)
            .background(Color(red: 0, green: 0.3922, blue: 0.6431))
            Divider()
                .frame(height: 5)
                .background(.white)
            Spacer()
            
            if let image = myDictionary[water_name] {
                Image(image.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 450)
            }
            Button("Locate") {
                showAlert = false
            }
            .padding()
            .foregroundColor(.white)
            .font(.system(size: 28, weight: .bold))
            Spacer()
            Button("Tap to Dismiss") {
                showAlert = false
            }
            .padding()
            .foregroundColor(.white)
            .font(.system(size: 18))
        }
        .frame(minWidth: 500, maxWidth: 500, minHeight: 700, maxHeight: 900)
        .background(Color(red: 0, green: 0.3922, blue: 0.6431))
        
    }
}
