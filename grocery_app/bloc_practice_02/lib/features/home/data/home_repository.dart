/// Example repository for Home feature.
/// In a real app this would fetch data from API / local DB.
class HomeRepository {
  Future<int> getInitialCounter() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return 0;
  }
}
