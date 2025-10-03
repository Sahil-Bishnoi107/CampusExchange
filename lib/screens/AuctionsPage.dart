import 'package:flutter/material.dart';

class Auctionspage extends StatefulWidget {
  const Auctionspage({super.key});

  @override
  State<Auctionspage> createState() => _AuctionspageState();
}

class _AuctionspageState extends State<Auctionspage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Auctions Page"),
    );
  }
}