import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify Clone',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Seção 1
                TitleSection(),
                // Seção 2
                ArtistGrid(),
                // Seção 3
                NewReleaseSection(),
                // Seção 4
                RecommendedPlaylists(),
                // Adicionando o espaçamento maior abaixo das playlists
                SizedBox(height: 32),
              ],
            ),
          ),
          // Seção 5
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Miniplayer(),
          ),
        ],
      ),
      bottomNavigationBar: BottomMenu(),
    );
  }
}

//Título e ícones

class TitleSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Ícone de usuário
          Icon(Icons.person, color: Colors.white, size: 28),
          // Opções "Tudo", "Músicas" e "Podcasts"
          Row(
            children: [
              Text('Tudo', style: TextStyle(color: Colors.white, fontSize: 16)),
              SizedBox(width: 16), // Espaçamento entre as opções
              Text('Músicas',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              SizedBox(width: 16), // Espaçamento entre as opções
              Text('Podcasts',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}

//Grid com artistas
class ArtistGrid extends StatelessWidget {
  final List<Artist> artists = [
    Artist('Matuê',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/Matu%C3%AA.png/250px-Matu%C3%AA.png'),
    Artist('Teto',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b0/Teto_2024.jpg/200px-Teto_2024.jpg'),
    Artist('Chorão',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/Chor%C3%A3o_em_algum_show_2008_colorized.jpg/250px-Chor%C3%A3o_em_algum_show_2008_colorized.jpg'),
    Artist('Mc Cabelinho',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/5/56/MC_Cabelinho_-_TVZ_2023_%281%29.png/200px-MC_Cabelinho_-_TVZ_2023_%281%29.png'),
    Artist('Travis Scott',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Travis_Scott_-_Openair_Frauenfeld_2019_08.jpg/250px-Travis_Scott_-_Openair_Frauenfeld_2019_08.jpg'),
    Artist('Filipe Ret',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/2/27/Filipe_Ret.jpg/250px-Filipe_Ret.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 3.0,
        ),
        itemCount: artists.length,
        itemBuilder: (context, index) {
          return ArtistCard(artist: artists[index]);
        },
      ),
    );
  }
}

// Model de artista para representar os dados de cada card
class Artist {
  final String name;
  final String imageUrl;

  Artist(this.name, this.imageUrl);
}

// Card de artista individual
class ArtistCard extends StatelessWidget {
  final Artist artist;

  const ArtistCard({required this.artist});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double responsivePadding = screenWidth * 0.03;

    return Container(
      padding: EdgeInsets.all(responsivePadding),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              artist.imageUrl,
              fit: BoxFit.cover,
              height: 50,
              width: 50,
            ),
          ),
          SizedBox(width: responsivePadding),
          Text(
            artist.name,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

// Novo lançamento
class NewReleaseSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/pt/thumb/4/42/Capa_do_%C3%A1lbum_333.jpeg/220px-Capa_do_%C3%A1lbum_333.jpeg ',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Matuê',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('Novo Lançamento', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          AlbumCard(),
        ],
      ),
    );
  }
}

// Card do álbum com a imagem, nome da música, artista, e botões
class AlbumCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Image.network(
            'https://upload.wikimedia.org/wikipedia/pt/thumb/2/29/Capa_do_%C3%A1lbum_M%C3%A1quina_do_Tempo.jpeg/220px-Capa_do_%C3%A1lbum_M%C3%A1quina_do_Tempo.jpeg',
            fit: BoxFit.cover,
            height: 180,
            width: double.infinity,
          ),
          Positioned(
            bottom: 10,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Máquina do Tempo',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
                Text('Albúm • Matuê',
                    style: TextStyle(fontSize: 14, color: Colors.white)),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 16,
            child: Row(
              children: [
                Icon(Icons.favorite_border, color: Colors.white),
                SizedBox(width: 16),
                Icon(Icons.play_arrow, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//Playlist recomendadas
class RecommendedPlaylists extends StatelessWidget {
  // Lista de playlists com dados personalizáveis
  final List<Playlist> playlists = [
    Playlist('This is Lil Peep',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Lil-Peep_PrettyPuke_Photoshoot.png/200px-Lil-Peep_PrettyPuke_Photoshoot.png'),
    Playlist('This is Linkin Park',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d8/Linkin_Park_-_From_Zero_Lead_Press_Photo_-_James_Minchin_III.jpg/300px-Linkin_Park_-_From_Zero_Lead_Press_Photo_-_James_Minchin_III.jpg'),
    Playlist('Only Eminem',
        'https://upload.wikimedia.org/wikipedia/en/thumb/4/4e/Eminem_-_The_Death_of_Slim_Shady_%28Coup_de_Gr%C3%A2ce%29.png/220px-Eminem_-_The_Death_of_Slim_Shady_%28Coup_de_Gr%C3%A2ce%29.png'),
    Playlist('Relax and Chill',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/Snoop_Dogg_in_2021.png/640px-Snoop_Dogg_in_2021.png'),
    Playlist('Playlist Wiz Khalifa',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Wiz_Khalifa_Stavernfestivalen_2018_%28231822%29.jpg/640px-Wiz_Khalifa_Stavernfestivalen_2018_%28231822%29.jpg'),
    Playlist('Melhores do 333',
        'https://upload.wikimedia.org/wikipedia/pt/thumb/4/42/Capa_do_%C3%A1lbum_333.jpeg/220px-Capa_do_%C3%A1lbum_333.jpeg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
            height: 200, // A altura da área de playlists
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                return PlaylistCard(playlist: playlists[index]);
              },
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}

// Model de Playlist para representar os dados de cada card
class Playlist {
  final String name;
  final String imageUrl;

  Playlist(this.name, this.imageUrl);
}

// Card de playlist individual
class PlaylistCard extends StatelessWidget {
  final Playlist playlist;

  const PlaylistCard({required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Image.network(
              playlist.imageUrl,
              width: 160,
              height: 120,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 10,
              left: 16,
              child: Text(
                playlist.name,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Miniplayer
class Miniplayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              'https://upload.wikimedia.org/wikipedia/pt/thumb/4/42/Capa_do_%C3%A1lbum_333.jpeg/220px-Capa_do_%C3%A1lbum_333.jpeg',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('333', style: TextStyle(fontSize: 14)),
              Text('Matuê', style: TextStyle(fontSize: 12)),
            ],
          ),
          Spacer(),
          Icon(Icons.computer, color: Colors.white),
          SizedBox(width: 12),
          Icon(Icons.favorite_border, color: Colors.white),
          SizedBox(width: 12),
          Icon(Icons.play_arrow, color: Colors.white),
        ],
      ),
    );
  }
}

// Menu inferior
class BottomMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.transparent,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
        BottomNavigationBarItem(
            icon: Icon(Icons.library_books), label: 'Sua Biblioteca'),
      ],
    );
  }
}
