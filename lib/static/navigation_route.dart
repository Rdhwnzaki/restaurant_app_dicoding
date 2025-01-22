enum NavigationRoute {
  mainRoute("/main"),
  detailRoute("/detail"),
  searchRoute("/search"),
  settingsRoute("/settings");

  const NavigationRoute(this.name);
  final String name;
}
