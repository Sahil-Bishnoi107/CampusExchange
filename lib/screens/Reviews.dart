import 'package:ecommerceapp/Models/ReviewModel.dart';
import 'package:ecommerceapp/providers/reviewsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReviewsPage extends StatefulWidget {
  String itemid;
  ReviewsPage({super.key,required this.itemid});

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  String selectedFilter = "All";
  bool isWritingReview = false;
  double tempRating = 0;
  final TextEditingController reviewController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<Reviewsprovider>().fetchReviews(widget.itemid);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(252, 248, 248, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(252, 248, 248, 1),
        title: const Text(
          "Reviews",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.red,
        label: Text(
          isWritingReview ? "Post Review" : "Write a Review",
          style: const TextStyle(color: Colors.white),
        ),
        onPressed: () {
          if (isWritingReview) {
            if (reviewController.text.isNotEmpty && tempRating > 0) {
              
              context.read<Reviewsprovider>().postReview(widget.itemid, tempRating.toInt(), reviewController.text );
              reviewController.clear();
              tempRating = 0;
              setState(() {
                isWritingReview = false;
              });
            }
          } else {
            setState(() {
              isWritingReview = true;
            });
          }
        },
      ),
      body: Consumer<Reviewsprovider>(
        builder: (context, provider, child) {
          final int total = provider.totalReviews;
          List<Widget> reviewWidgets = [];
          if (isWritingReview) reviewWidgets.add(_buildInlineReviewCard());
          reviewWidgets.addAll(provider.reviewList
              .where((review) =>
                  selectedFilter == "All" ||
                  review.rating.toString().startsWith(selectedFilter))
              .map((review) => _buildReviewCard(review))
              .toList());

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          provider.averageRating.toStringAsFixed(1),
                          style: const TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              Icons.star,
                              color: index < provider.averageRating.round()
                                  ? Colors.red
                                  : const Color.fromRGBO(231, 208, 209, 1),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text("${provider.totalReviews} reviews"),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        children: [
                          _buildRatingBar("5", provider.fiveStars, total),
                          _buildRatingBar("4", provider.fourStars, total),
                          _buildRatingBar("3", provider.threeStars, total),
                          _buildRatingBar("2", provider.twoStars, total),
                          _buildRatingBar("1", provider.oneStars, total),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildFilterButton("All"),
                    _buildFilterButton("5"),
                    _buildFilterButton("4"),
                  ],
                ),
                const SizedBox(height: 16),
                ...reviewWidgets,
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildRatingBar(String label, int count, int total) {
    double percent = total == 0 ? 0.0 : (count / total) * 100.0;
    return Row(
      children: [
        Text(label),
        const SizedBox(width: 4),
        Container(
          width: 200,
          padding: const EdgeInsets.only(left: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              minHeight: 10,
              value: percent / 100.0,
              color: Colors.red,
              backgroundColor: const Color.fromRGBO(231, 208, 209, 1),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text("${percent.toStringAsFixed(0)}%")),
      ],
    );
  }

  Widget _buildFilterButton(String filter) {
    bool isSelected = selectedFilter == filter;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        backgroundColor: const Color.fromRGBO(231, 208, 209, 1),
        selectedColor: Colors.red,
        showCheckmark: true,
        checkmarkColor: Colors.white,
        side: BorderSide(color: isSelected ? Colors.red : Colors.white),
        label: Text(
          filter == "All" ? "All" : "$filter star",
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
        selected: isSelected,
        onSelected: (_) {
          setState(() {
            selectedFilter = filter;
          });
        },
      ),
    );
  }

  Widget _buildReviewCard(Review review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(252, 248, 248, 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(backgroundImage: NetworkImage(review.userImageUrl)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(review.userName,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(Icons.star,
                        size: 16,
                        color: index < review.rating ? Colors.red : Colors.grey),
                  ),
                ),
                const SizedBox(height: 4),
                Text(review.comment),
                const SizedBox(height: 4),
                Text(
                  "${DateTime.parse(review.datetime).toLocal().toString().split(' ')[0]}",
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInlineReviewCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(252, 248, 248, 1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Your Review",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.grey),
                onPressed: () {
                  setState(() {
                    isWritingReview = false;
                    reviewController.clear();
                    tempRating = 0;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(
              5,
              (index) => IconButton(
                onPressed: () {
                  setState(() {
                    tempRating = index + 1.0;
                  });
                },
                icon: Icon(
                  Icons.star,
                  size: 32,
                  color: index < tempRating ? Colors.red : Colors.grey,
                ),
              ),
            ),
          ),
          TextField(
            controller: reviewController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: "Write your review here...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
