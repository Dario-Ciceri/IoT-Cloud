import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final Widget? header;
  final List<AppDrawerItem> menuItems;
  final List<AppDrawerSection>? sections;
  final Widget? footer;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? unselectedColor;
  final TextStyle? selectedTextStyle;
  final TextStyle? unselectedTextStyle;
  final double width;
  final double elevation;
  final BorderRadius? borderRadius;
  final int? selectedIndex;

  const AppDrawer({
    super.key,
    this.header,
    required this.menuItems,
    this.sections,
    this.footer,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.selectedTextStyle,
    this.unselectedTextStyle,
    this.width = 280,
    this.elevation = 16,
    this.borderRadius,
    this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    final router = context.router;

    // Safely get TabsRouter if available, otherwise it remains null
    TabsRouter? tabsRouter;
    try {
      tabsRouter = context.tabsRouter;
    } catch (e) {
      // TabsRouter not available, continue without it
    }

    final theme = Theme.of(context);
    final backgroundColor =
        this.backgroundColor ??
        theme.drawerTheme.backgroundColor ??
        theme.canvasColor;
    final selectedColor = this.selectedColor ?? theme.primaryColor;
    final unselectedColor = this.unselectedColor ?? theme.unselectedWidgetColor;
    final selectedTextStyle =
        this.selectedTextStyle ??
        theme.textTheme.titleMedium?.copyWith(
          color: selectedColor,
          fontWeight: FontWeight.w600,
        );
    final unselectedTextStyle =
        this.unselectedTextStyle ??
        theme.textTheme.titleMedium?.copyWith(color: unselectedColor);
    final borderRadius =
        this.borderRadius ??
        const BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        );

    return Drawer(
      width: width,
      elevation: elevation,
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      child: SafeArea(
        child: Column(
          children: [
            if (header != null) header!,
            if (header != null) const SizedBox(height: 8),

            // If sections are provided, use them
            if (sections != null) ...[
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: sections!.length,
                  itemBuilder: (context, sectionIndex) {
                    final section = sections![sectionIndex];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (section.title != null)
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              top: 16,
                              bottom: 8,
                            ),
                            child: Text(
                              section.title!,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.secondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ...section.items.map((item) {
                          final index = menuItems.indexOf(item);
                          bool isSelected = false;

                          // Determine if item is selected based on route or index
                          if (item.routeInfo != null && tabsRouter != null) {
                            // For tabs router, check if the active tab matches this route
                            isSelected =
                                tabsRouter.currentPath.contains(
                                  item.routeInfo!.routeName,
                                ) ||
                                item.tabIndex == tabsRouter.activeIndex;
                          } else if (item.routeInfo != null) {
                            // For regular router, just check if the current route matches
                            isSelected = router.currentPath.contains(
                              item.routeInfo!.routeName,
                            );
                          } else if (selectedIndex != null) {
                            isSelected = index == selectedIndex;
                          }

                          return _buildMenuItem(
                            context,
                            item,
                            isSelected,
                            selectedColor,
                            unselectedColor,
                            selectedTextStyle,
                            unselectedTextStyle,
                            index,
                            router,
                            tabsRouter,
                          );
                        }),
                        if (sectionIndex < sections!.length - 1 ||
                            footer != null)
                          const Divider(),
                      ],
                    );
                  },
                ),
              ),
            ] else ...[
              // Otherwise just use menuItems directly
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    final item = menuItems[index];
                    bool isSelected = false;

                    // Determine if item is selected based on route or index
                    if (item.routeInfo != null && tabsRouter != null) {
                      // For tabs router, check if the active tab matches this route
                      isSelected =
                          tabsRouter.currentPath.contains(
                            item.routeInfo!.routeName,
                          ) ||
                          item.tabIndex == tabsRouter.activeIndex;
                    } else if (item.routeInfo != null) {
                      // For regular router, just check if the current route matches
                      isSelected = router.currentPath.contains(
                        item.routeInfo!.routeName,
                      );
                    } else if (selectedIndex != null) {
                      isSelected = index == selectedIndex;
                    }

                    return _buildMenuItem(
                      context,
                      item,
                      isSelected,
                      selectedColor,
                      unselectedColor,
                      selectedTextStyle,
                      unselectedTextStyle,
                      index,
                      router,
                      tabsRouter,
                    );
                  },
                ),
              ),
            ],

            if (footer != null) footer!,
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    AppDrawerItem item,
    bool isSelected,
    Color selectedColor,
    Color unselectedColor,
    TextStyle? selectedTextStyle,
    TextStyle? unselectedTextStyle,
    int index,
    StackRouter router,
    TabsRouter? tabsRouter,
  ) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        leading: Icon(
          item.icon,
          color: isSelected ? selectedColor : unselectedColor,
          size: 24,
        ),
        title: Text(
          item.title,
          style: isSelected ? selectedTextStyle : unselectedTextStyle,
        ),
        subtitle: item.subtitle != null ? Text(item.subtitle!) : null,
        trailing: item.trailing,
        selected: isSelected,
        selectedTileColor: selectedColor.withOpacity(
          0.1,
        ), // Fixed withValues to withOpacity
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        dense: true,
        onTap: () {
          // Handle navigation
          if (item.routeInfo != null) {
            if (tabsRouter != null && item.tabIndex != null) {
              // If we have a tabs router and the item has a tab index, use the tabs router
              tabsRouter.setActiveIndex(item.tabIndex!);
            } else {
              // Use regular navigation
              router.navigate(item.routeInfo!);
            }
          } else if (item.onTap != null) {
            // If we have an onTap callback, use it
            item.onTap!();
          }

          // Close the drawer after navigation
          if (item.closeDrawerOnTap) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}

class AppDrawerItem {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Widget? trailing;
  final PageRouteInfo? routeInfo;
  final int? tabIndex;
  final VoidCallback? onTap;
  final bool closeDrawerOnTap;

  const AppDrawerItem({
    required this.title,
    this.subtitle,
    required this.icon,
    this.trailing,
    this.routeInfo,
    this.tabIndex,
    this.onTap,
    this.closeDrawerOnTap = true,
  });
}

class AppDrawerSection {
  final String? title;
  final List<AppDrawerItem> items;

  const AppDrawerSection({this.title, required this.items});
}

// Example header for the drawer
class AppDrawerHeader extends StatelessWidget {
  final String userName;
  final String? userEmail;
  final String? avatarUrl;
  final VoidCallback? onProfileTap;
  final PageRouteInfo? profileRoute;
  final Color? backgroundColor;
  final Color? textColor;

  const AppDrawerHeader({
    super.key,
    required this.userName,
    this.userEmail,
    this.avatarUrl,
    this.onProfileTap,
    this.profileRoute,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = this.textColor ?? theme.colorScheme.onPrimary;
    final backgroundColor = this.backgroundColor ?? theme.primaryColor;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(color: backgroundColor),
      child: InkWell(
        onTap: () {
          if (profileRoute != null) {
            context.router.navigate(profileRoute!);
            Navigator.of(context).pop();
          } else if (onProfileTap != null) {
            onProfileTap!();
          }
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: Colors.white.withOpacity(
                0.2,
              ), // Fixed withValues to withOpacity
              backgroundImage:
                  avatarUrl != null ? NetworkImage(avatarUrl!) : null,
              child:
                  avatarUrl == null
                      ? Text(
                        userName.isNotEmpty ? userName[0].toUpperCase() : "?",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      )
                      : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    userName,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (userEmail != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      userEmail!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: textColor.withOpacity(
                          0.8,
                        ), // Fixed withValues to withOpacity
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: textColor.withOpacity(
                0.8,
              ), // Fixed withValues to withOpacity
            ),
          ],
        ),
      ),
    );
  }
}
