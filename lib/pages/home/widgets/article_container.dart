import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:real_world/bloc/home/home_bloc.dart';
import 'package:real_world/bloc/home/home_event.dart';
import 'package:real_world/common/widgets/app_font.dart';
import 'package:real_world/constants/gaps.dart';
import 'package:real_world/constants/sizes.dart';
import 'package:real_world/models/article_model.dart';
import 'package:real_world/pages/home/widgets/tag_button.dart';

class ArticleContainer extends StatelessWidget {
  final ArticleModel article;

  const ArticleContainer({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shape: const LinearBorder(),
        padding: const EdgeInsets.all(Sizes.size20),
      ),
      onPressed: () async {
        await context.push('/article/${article.slug}');
        context.read<HomeBloc>().add(HomeGetArticles(
              page: context.read<HomeBloc>().state.page,
            ));
      },
      child: Container(
        decoration: const BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.push('/profile/${article.author?.username}');
                      },
                      child: AppFont(
                        article.author?.username ?? 'N/A',
                        style: const TextStyle(
                          fontSize: Sizes.size16,
                        ),
                      ),
                    ),
                    AppFont(
                      article.createdAt.toString(),
                      style: TextStyle(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(Sizes.size10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(Sizes.size5),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.favorite,
                        size: Sizes.size16,
                      ),
                      Gaps.h3,
                      AppFont(article.favoritesCount.toString()),
                    ],
                  ),
                ),
              ],
            ),
            Gaps.v10,
            AppFont(
              article.title ?? 'N/A',
              style: const TextStyle(
                color: Colors.black87,
                fontSize: Sizes.size18,
                fontWeight: FontWeight.w700,
              ),
            ),
            AppFont(
              article.body?.replaceAll("\\n", '\n') ?? 'N/A',
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
              maxLine: 2,
            ),
            Gaps.v16,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: Sizes.size5),
                  child: AppFont(
                    'Read more...',
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: Sizes.size12,
                    ),
                  ),
                ),
                Gaps.h10,
                Expanded(
                  child: Wrap(
                    runSpacing: Sizes.size5,
                    spacing: Sizes.size5,
                    alignment: WrapAlignment.end,
                    children: [
                      for (var tag in article.tagList ?? [])
                        TagButton(tag: tag),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
