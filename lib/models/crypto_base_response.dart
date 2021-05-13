// To parse this JSON data, do
//
//     final cryptoBaseResponse = cryptoBaseResponseFromJson(jsonString);

import 'dart:convert';

CryptoBaseResponse cryptoBaseResponseFromJson(String str) => CryptoBaseResponse.fromJson(json.decode(str));


class CryptoBaseResponse {
    CryptoBaseResponse({
        this.status,
        this.data,
    });

    Status? status;
    List<Datum?>? data;

    factory CryptoBaseResponse.fromJson(Map<String, dynamic> json) => CryptoBaseResponse(
        status: Status.fromJson(json["status"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

}

class Datum {
    Datum({
        this.id,
        this.name,
        this.symbol,
        this.slug,
        this.numMarketPairs,
        this.dateAdded,
        this.tags,
        this.maxSupply,
        this.circulatingSupply,
        this.totalSupply,
        this.platform,
        this.cmcRank,
        this.lastUpdated,
        this.quote,
    });

    int? id;
    String? name;
    String? symbol;
    String? slug;
    int? numMarketPairs;
    DateTime? dateAdded;
    List<String>? tags;
    int? maxSupply;
    double? circulatingSupply;
    double? totalSupply;
    Platform? platform;
    int? cmcRank;
    DateTime? lastUpdated;
    Quote? quote;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        symbol: json["symbol"],
        slug: json["slug"],
        numMarketPairs: json["num_market_pairs"],
        dateAdded: DateTime.parse(json["date_added"]),
        tags: List<String>.from(json["tags"].map((x) => x)),
        maxSupply: json["max_supply"] == null ? null : json["max_supply"],
        circulatingSupply: json["circulating_supply"].toDouble(),
        totalSupply: json["total_supply"].toDouble(),
        platform: json["platform"] == null ? null : Platform.fromJson(json["platform"]),
        cmcRank: json["cmc_rank"],
        lastUpdated: DateTime.parse(json["last_updated"]),
        quote: Quote.fromJson(json["quote"]),
    );
}

class Platform {
    Platform({
        this.id,
        this.name,
        this.symbol,
        this.slug,
        this.tokenAddress,
    });

    int? id;
    Name? name;
    Symbol? symbol;
    Slug? slug;
    String? tokenAddress;

    factory Platform.fromJson(Map<String, dynamic> json) => Platform(
        id: json["id"],
        name: nameValues.map?[json["name"]],
        symbol: symbolValues.map?[json["symbol"]],
        slug: slugValues.map?[json["slug"]],
        tokenAddress: json["token_address"],
    );
}

enum Name { ETHEREUM, BINANCE_CHAIN, BINANCE_SMART_CHAIN, TRON }

final nameValues = EnumValues({
    "Binance Chain": Name.BINANCE_CHAIN,
    "Binance Smart Chain": Name.BINANCE_SMART_CHAIN,
    "Ethereum": Name.ETHEREUM,
    "Tron": Name.TRON
});

enum Slug { ETHEREUM, BINANCE_COIN, TRON }

final slugValues = EnumValues({
    "binance-coin": Slug.BINANCE_COIN,
    "ethereum": Slug.ETHEREUM,
    "tron": Slug.TRON
});

enum Symbol { ETH, BNB, TRX }

final symbolValues = EnumValues({
    "BNB": Symbol.BNB,
    "ETH": Symbol.ETH,
    "TRX": Symbol.TRX
});

class Quote {
    Quote({
        this.usd,
    });

    Usd? usd;

    factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        usd: Usd.fromJson(json["USD"]),
    );
}

class Usd {
    Usd({
        this.price,
        this.volume24H,
        this.percentChange1H,
        this.percentChange24H,
        this.percentChange7D,
        this.percentChange30D,
        this.percentChange60D,
        this.percentChange90D,
        this.marketCap,
        this.lastUpdated,
    });

    double? price;
    double? volume24H;
    double? percentChange1H;
    double? percentChange24H;
    double? percentChange7D;
    double? percentChange30D;
    double? percentChange60D;
    double? percentChange90D;
    double? marketCap;
    DateTime? lastUpdated;

    factory Usd.fromJson(Map<String, dynamic> json) => Usd(
        price: json["price"].toDouble(),
        volume24H: json["volume_24h"].toDouble(),
        percentChange1H: json["percent_change_1h"].toDouble(),
        percentChange24H: json["percent_change_24h"].toDouble(),
        percentChange7D: json["percent_change_7d"].toDouble(),
        percentChange30D: json["percent_change_30d"].toDouble(),
        percentChange60D: json["percent_change_60d"].toDouble(),
        percentChange90D: json["percent_change_90d"].toDouble(),
        marketCap: json["market_cap"].toDouble(),
        lastUpdated: DateTime.parse(json["last_updated"]),
    );
}

class Status {
    Status({
        this.timestamp,
        this.errorCode,
        this.errorMessage,
        this.elapsed,
        this.creditCount,
        this.notice,
        this.totalCount,
    });

    DateTime? timestamp;
    int? errorCode;
    dynamic? errorMessage;
    int? elapsed;
    int? creditCount;
    dynamic? notice;
    int? totalCount;

    factory Status.fromJson(Map<String, dynamic> json) => Status(
        timestamp: DateTime.parse(json["timestamp"]),
        errorCode: json["error_code"],
        errorMessage: json["error_message"],
        elapsed: json["elapsed"],
        creditCount: json["credit_count"],
        notice: json["notice"],
        totalCount: json["total_count"],
    );

    Map<String, dynamic> toJson() => {
        "timestamp": timestamp?.toIso8601String(),
        "error_code": errorCode,
        "error_message": errorMessage,
        "elapsed": elapsed,
        "credit_count": creditCount,
        "notice": notice,
        "total_count": totalCount,
    };
}

class EnumValues<T> {
    Map<String, T>? map;
    Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String>? get reverse {
        if (reverseMap == null) {
            reverseMap = map?.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
