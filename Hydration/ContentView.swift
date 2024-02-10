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
    @State var camera: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var isSatelliteView: Bool = false
//    @StateObject var manager = LocationManager()
    @State private var showAlert = false
    @State private var getDirections = false

    @State private var routeDisplaying = false
    @State private var route: MKRoute?
    @State private var routeDestination: MKMapItem?
    
    struct Locations {
        var name: String
        var coordinates: CLLocationCoordinate2D
    }
    
    // Define the locations array
    private var locations: [Locations] = [
        Locations(name: "DBH", coordinates: .water_dbh),
        Locations(name: "Engineering Tower", coordinates: .water_eng_tower),
        Locations(name: "Langson Library", coordinates: .water_langson_library),
        Locations(name: "SSLH", coordinates: .water_sslh),
        Locations(name: "SST", coordinates: .water_sst),
        Locations(name: "SSL", coordinates: .water_ssl),
        Locations(name: "Steinhaus Hall", coordinates: .water_steinhaus),
        Locations(name: "Howard Schneiderman", coordinates: .water_howard),
        Locations(name: "Science Library", coordinates: .water_science_library),
        Locations(name: "Student Center", coordinates: .water_student_center),
    ]

    let hydration_icon = "hydration_icon"
    @State private var selectedLocationName: String = ""
    
    var body: some View {
        VStack {
            
            // MAIN PAGE
//            var selectedLocationName: String = ""
            Map(position: $camera){
                UserAnnotation()
                ForEach(locations, id: \.name) { location in
                    Annotation(location.name, coordinate: location.coordinates) {
                        ZStack {
                            Image(hydration_icon)
                                .resizable()
                                .padding(5)
                                .frame(width: 35, height: 35)
                                .foregroundColor(.red)
                        }
                        .onTapGesture {
                            showAlert = true
                            selectedLocationName = location.name
                            print("Selected Location Name in onTapGesture: \(selectedLocationName)")
                        }
                        .sheet(isPresented: $showAlert) {
                            CustomAlertView(showAlert: $showAlert, getDirections: $getDirections, water_name: selectedLocationName)
                        }
                    }
                }
                
                if let route{
                    MapPolyline(route.polyline)
                        .stroke(.blue, lineWidth:6)
                }
            }
            //-------------------------------------------------
            .mapControls{
                MapUserLocationButton()
                //MapPitchToggle()
            }
            //-------------------------------------------------
            .onAppear{
                CLLocationManager().requestWhenInUseAuthorization()
            }
            //-------------------------------------------------
            .safeAreaInset(edge: .top){
                HStack(alignment: .center){
                    ZStack{
                        HStack{
                            Button(action: {
                                // Action to perform when hamburger button is tapped
                                
                            }) {
                                Image(systemName: "line.horizontal.3")
                                    .resizable()
                                    .frame(width: 30, height: 20)
                                    .foregroundColor(.white)
                            }.padding([.leading])
                            Spacer()
                        }
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
                    }
                }
                .background(Color(red: 0, green: 0.3922, blue: 0.6431))
            }
            //-------------------------------------------------
            .safeAreaInset(edge: .bottom){
                HStack{
                    Spacer()
                    Button{
//                        camera = .region(MKCoordinateRegion(center:.center_uci, latitudinalMeters: 150, longitudinalMeters: 150))
//                        showMapView.toggle()
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
            //-------------------------------------------------
            .onChange(of: getDirections, {oldValue, newValue in
                if newValue{
                    print("Selected Location Name in onChange: \(selectedLocationName)")
                    searchPlaces()
                }
            })
            .mapStyle(isSatelliteView ? .imagery : .standard)
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
    
    func updateUIView(_ uiView: MKMapView, context: Context) {}
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .systemBlue
            renderer.lineWidth = 5
            return renderer
        }
    }
}


extension ContentView{
    func searchPlaces(){
        let x = locations.first { $0.name == selectedLocationName }?.coordinates
        if let userLocation = CLLocationManager().location?.coordinate, let destinationCoordinates = x {
            let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinates)
            
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation))
            request.destination = MKMapItem(placemark: destinationPlacemark)
            
            Task{
                let result = try? await MKDirections(request: request).calculate()
                route = result?.routes.first
                routeDestination = MKMapItem(placemark: destinationPlacemark)
                
//                withAnimation(.snappy){
//                    routeDisplaying = true
//                    showDetails = false
//
//                    if let rect - route?.polyline.boundingMapRect, routeDisplaying {
//                        camera = .rect(rect)
//                    }
//                }
            }
        }
    }
}

struct CustomAlertView: View {
    @Binding var showAlert: Bool
    @Binding var getDirections: Bool
    
    struct Bathroom {
        var description: String
        var image: String
    }
    
    var water_name: String
    var myDictionary: [String: Bathroom] = [
        "DBH": Bathroom(description: "DBH", image: "science_library_restroom"),
        "Engineering Tower": Bathroom(description: "Engineering Tower", image: "restroom2"),
        "Langson Library": Bathroom(description: "Langson Library", image: "restroom3"),
        "SSLH": Bathroom(description: "Social Science Lecture", image: "restroom4"),
        "SST": Bathroom(description: "Social Science Tower", image: "restroom5"),
        "SSL": Bathroom(description: "Social Science Lab", image: "restroom6"),
        "Steinhaus Hall": Bathroom(description: "Steinhaus Hall", image: "restroom2"),
        "Howard Schneiderman": Bathroom(description: "Howard Schneiderman", image: "restroom2"),
        "Science Library": Bathroom(description: "Science Library", image: "restroom2"),
        "Student Center": Bathroom(description: "Student Center", image: "restroom2")
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
                getDirections = true
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

class SideMenuViewController: UIViewController {
    
    var isVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Additional setup for your side menu
    }
    
    func show() {
        // Implement animation to show the side menu
        isVisible = true
    }
    
    func hide() {
        // Implement animation to hide the side menu
        isVisible = false
    }
}
