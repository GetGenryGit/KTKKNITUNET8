using KTKGuest.Shared.Utilities;

namespace KTKGuest.Client;

public partial class MainPage : ContentPage
{
    public MainPage()
    {
        InitializeComponent();
    }

    private void RefreshView_OnRefreshing(object sender, EventArgs e)
    {
        if (RefreshablePageBase.Current?.NavigationManager != null)
        {
            var navigationManager = RefreshablePageBase.Current.NavigationManager;
            navigationManager.NavigateTo(navigationManager.Uri, true, true);
            RefreshView.IsRefreshing = false;
        }
    }
}
