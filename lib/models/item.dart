class Item {
  String title;
  String explanation;
  String hdurl;
  String mediaType;
  String serviceVersion;
  String url;

  Item({
    this.title,
    this.explanation,
    this.hdurl,
    this.mediaType,
    this.serviceVersion,
    this.url,
  });

  Item.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    explanation = json['explanation'];
    hdurl = json['hdurl'];
    mediaType = json['mediaType'];
    serviceVersion = json['serviceVersion'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['explanation'] = this.explanation;
    data['hdurl'] = this.hdurl;
    data['mediaType'] = this.mediaType;
    data['serviceVersion'] = this.serviceVersion;
    data['url'] = this.url;
    return data;
  }
}

// {
//   "date":"2019-04-04",
//   "explanation": "After the Crab Nebula, M1, this giant star cluster is the second entry in 18th
//       century astronomer Charles Messier's famous list of things that are not comets. M2 is one of
//       the largest globular star clusters now known to roam the halo of our Milky Way galaxy.
//       Though Messier originally described it as a nebula without stars, this stunning Hubble
//       image resolves stars across the central 40 light-years of M2. Its population of stars
//       numbers close to 150,000, concentrated within a total diameter of around 175 light-years.
//       About 55,000 light-years distant toward the constellation Aquarius, this ancient denizen
//       of the Milky Way, also known as NGC 7089, is 13 billion years old.",
//   "hdurl":"https://apod.nasa.gov/apod/image/1904/potw1913aa.jpg",
//   "media_type":"image",
//   "service_version":"v1",
//   "title":"Messier 2",
//   "url":"https://apod.nasa.gov/apod/image/1904/potw1913aM2_1024.jpg"
//   }
