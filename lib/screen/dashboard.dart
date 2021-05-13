import 'package:cryptoapp/bloc/crypto_bloc.dart';
import 'package:cryptoapp/models/crypto_base_response.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final cryptoBloc = CryptoBloc();
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];
  final ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    cryptoBloc.eventSink.add(CryptoAction.FETCH);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        cryptoBloc.eventSink.add(CryptoAction.LOADMORE);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    cryptoBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crypto"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          cryptoBloc.eventSink.add(CryptoAction.FETCH);
        },
        child: Container(
          child: StreamBuilder<List<Datum?>>(
            stream: cryptoBloc.latestCurrenciesStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return _errorState(snapshot);
              } else if (snapshot.hasData) {
                return _buildCurrenciesList(snapshot);
              } else {
                return _shimmerLoadingState;
              }
            },
          ),
        ),
      ),
    );
  }

  Container _buildCurrenciesList(AsyncSnapshot<List<Datum?>> snapshot) {
    return Container(
      child: Column(
        children: [
          new Flexible(
            child: new ListView.builder(
              controller: _scrollController,
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                final MaterialColor color = _colors[index % _colors.length];
                final Datum? datum = snapshot.data?[index] ?? null;
                if (datum != null) {
                  return _getListItemUi(datum, color);
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Center _errorState(AsyncSnapshot<List<Datum?>> snapshot) {
    return Center(
      child: Text("${snapshot.error}"),
    );
  }

  Widget _shimmerLoadingState = Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
    child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
      Expanded(
        child: Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.grey,
          child: ListView.builder(
            itemBuilder: (_, __) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 48.0,
                    height: 48.0,
                    color: Colors.white,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 8.0,
                          color: Colors.white,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Container(
                          width: double.infinity,
                          height: 8.0,
                          color: Colors.white,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Container(
                          width: 40.0,
                          height: 8.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            itemCount: 6,
          ),
        ),
      ),
    ]),
  );

  ListTile _getListItemUi(Datum currency, MaterialColor color) {
    final quotes = currency.quote;
    final usdPrice = quotes?.usd;
    final price = usdPrice?.price;
    final percentageChange = usdPrice?.percentChange1H;
    final avatarText = currency.name?.substring(0, 1) ?? "";
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        child: new Text(avatarText),
      ),
      title: new Text(
        currency.name ?? "",
        style: new TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: _getSubtitleText(price ?? 0, percentageChange ?? 0),
      isThreeLine: true,
    );
  }

  Widget _getSubtitleText(double priceUSD, double percentageChange) {
    String percentChange = percentageChange.toStringAsFixed(2);
    String priceUsdAsString = priceUSD.toStringAsFixed(2);
    TextSpan priceTextWidget = new TextSpan(
        text: "\$$priceUsdAsString\n",
        style: new TextStyle(color: Colors.black));

    String percentageChangeText = "1 hour: $percentChange%";
    TextSpan percentageChangeTextWidgte;

    if (percentageChange > 0) {
      percentageChangeTextWidgte = new TextSpan(
          text: percentageChangeText,
          style: new TextStyle(color: Colors.green));
    } else {
      percentageChangeTextWidgte = new TextSpan(
          text: percentageChangeText, style: new TextStyle(color: Colors.red));
    }
    return new RichText(
        text: new TextSpan(
            children: [priceTextWidget, percentageChangeTextWidgte]));
  }
}
