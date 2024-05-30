import wx
import wx.lib.mixins.listctrl
from content import DealDetail

import db_manager
from forms import ClientAddForm, DealAddForm, ClientEditForm


class ListCtrlMixins(wx.ListCtrl, wx.lib.mixins.listctrl.ListCtrlAutoWidthMixin,
                     wx.lib.mixins.listctrl.ColumnSorterMixin):
    def __init__(self, parent, *args, **kw):
        wx.ListCtrl.__init__(self, parent, wx.ID_ANY, style=wx.LC_REPORT)
        wx.lib.mixins.listctrl.ListCtrlAutoWidthMixin.__init__(self)
        wx.lib.mixins.listctrl.ColumnSorterMixin.__init__(self, len(db_manager.DbConnection.execute_select(
            query='SELECT id, CONCAT(name, last_name), phone, email FROM users')))

        self.itemDataMap = db_manager.DbConnection.execute_select(
            query='SELECT id, CONCAT(name, last_name), phone, email FROM users')

    def GetListCtrl(self):
        return self


class MainFrame(wx.Frame):
    def __init__(self, parent, title, manager):
        super().__init__(parent, title=title)

        self.manager = 1

        # Create toolbar
        toolbar = self.CreateToolBar(wx.TB_TEXT)
        new_client = toolbar.AddTool(wx.ID_ANY, 'New client', wx.Bitmap('icons/add_client.png'))
        new_deal = toolbar.AddTool(wx.ID_ANY, 'New deal', wx.Bitmap('icons/add_deal.png'))
        toolbar.Realize()

        # Toolbar events
        self.Bind(wx.EVT_TOOL, self.create_client, new_client)
        self.Bind(wx.EVT_TOOL, self.create_deal, new_deal)

        # Create tabs
        tabs = wx.Notebook(self, id=wx.ID_ANY)
        tabs.SetPadding(wx.Size(30, 5))
        tabs.SetFont(wx.Font(wx.FontInfo(12)))

        # Create tab of deals
        self.splitter = wx.SplitterWindow(tabs)
        self.left_panel = wx.Panel(self.splitter)

        # Left side
        sizer_left = wx.BoxSizer(wx.VERTICAL)
        instance = db_manager.DealsModification()
        self.orders = instance.get_items_list(fields=['id'], order_by=('id', 'desc'))
        self.order_list = wx.ListCtrl(self.left_panel, style=wx.LC_REPORT)
        self.order_list.InsertColumn(0, "Order №", width=wx.EXPAND)
        for order_id in self.orders:
            self.order_list.Append(['Order #' + str(order_id[0])])

        self.order_list.Bind(wx.EVT_LIST_ITEM_SELECTED, self.on_order_selected)
        sizer_left.Add(self.order_list, 1, wx.EXPAND)
        self.left_panel.SetSizer(sizer_left)

        # right side
        self.right_panel = DealDetail(self.splitter)

        # Put together
        self.splitter.SplitVertically(self.left_panel, self.right_panel)
        self.splitter.SetMinimumPaneSize(300)

        # Create tab of clients
        data = db_manager.UsersModification()
        self.clients = data.get_items_list(fields=['id', 'name', 'phone', 'email'], order_by=('id', 'asc'), where=('role_id', 2))
        self.list_ctrl = ListCtrlMixins(tabs, style=wx.LC_REPORT)
        self.list_ctrl.InsertColumn(0, "№", width=100)
        self.list_ctrl.InsertColumn(1, "Name", width=200)
        self.list_ctrl.InsertColumn(2, "Phone", width=200)
        self.list_ctrl.InsertColumn(3, "Email", width=250)
        # self.list_ctrl.InsertColumn(2, "Registration date", width=200)

        for client_info in self.clients:
            self.list_ctrl.Append(client_info)

        # Add tabs
        tabs.InsertPage(0, self.splitter, "Deals", select=True)
        tabs.InsertPage(1, self.list_ctrl, "Clients", )

        self.list_ctrl.Bind(wx.EVT_LIST_ITEM_ACTIVATED, self.on_client_edit)

    def create_client(self, event):
        with ClientAddForm(self, 'Add new client') as dlg:
            dlg.ShowModal()

    def create_deal(self, event):
        with DealAddForm(self, 'Add new deal') as dlg:
            dlg.ShowModal()

    def on_order_selected(self, event):
        selected_item = self.order_list.GetFirstSelected()
        if selected_item != -1:
            selected_order_id = int(self.order_list.GetItemText(selected_item).split('#')[-1])
            instance = db_manager.DealsModification()
            order_details = instance.get_details(deal_id=selected_order_id)[0]
            comments = instance.get_comments(deal_id=selected_order_id)
            self.right_panel.manager = self.manager
            self.right_panel.get_comments(comments)
            self.right_panel.order_id_text.SetLabel(str(selected_order_id))
            self.right_panel.name_text.SetLabel(order_details[1])
            self.right_panel.phone_text.SetLabel(order_details[2])
            self.right_panel.address_text.SetLabel(order_details[3])
            self.right_panel.email_text.SetLabel(order_details[4])
            self.right_panel.manager_text.SetLabel(order_details[5])
            self.right_panel.status_label.SetLabel(order_details[6])
            self.right_panel.status_list.SetSelection(int(self.right_panel.status_choices[order_details[6]])-1)
            self.right_panel.desc_text.SetLabel(order_details[7])
            self.right_panel.created_text.SetLabel(order_details[8])
            self.right_panel.updated_text.SetLabel(order_details[9])
            comments_text = ''
            for c in comments:
                comments_text += c[-1] + '\n ____________ \n \n'
            self.right_panel.comments_text.SetLabel(comments_text)

    def on_client_edit(self, event):
        selected_item = event.GetText()
        if selected_item != -1:
            dialog = ClientEditForm(self, selected_item)
            dialog.ShowModal()

class LoginWindow(wx.Dialog):
    def __init__(self, parent, title):
        super().__init__(parent, title=title, size=(450, 300))

        self.Centre()
        self.SetFont(wx.Font(wx.FontInfo(12)))

        v_sizer = wx.BoxSizer(wx.VERTICAL)
        fields_sizer = wx.GridSizer(2, 2, 20, 0)
        self.username_label = wx.StaticText(self, label="Username")
        self.username_text = wx.TextCtrl(self, size=(250, 30))
        self.password_label = wx.StaticText(self, label="Password")
        self.password_text = wx.TextCtrl(self, style=wx.TE_PASSWORD, size=(250, 30))

        fields_sizer.AddMany([(self.username_label, 0, wx.ALIGN_CENTER, 5),
                              (self.username_text, 0, wx.EXPAND),
                              (self.password_label, 0, wx.ALIGN_CENTER, 5),
                              (self.password_text, 0, wx.EXPAND)
                              ])

        self.login_button = wx.Button(self, label="Login", size=(100, 30))
        self.exit_button = wx.Button(self, label="Exit", size=(100, 30))

        h_sizer = wx.BoxSizer(wx.HORIZONTAL)
        h_sizer.AddMany([(self.login_button, 0, wx.ALIGN_CENTER | wx.ALL, 50),
                         (self.exit_button, 0, wx.ALIGN_CENTER | wx.ALL, 10)
                         ])

        self.login_button.Bind(wx.EVT_BUTTON, self.onLogin)
        self.exit_button.Bind(wx.EVT_CLOSE, self.onQuit)

        v_sizer.Add(fields_sizer, flag=wx.ALIGN_CENTER | wx.ALL, border=10)
        v_sizer.Add(h_sizer, flag=wx.ALIGN_CENTER | wx.ALL, border=10)
        self.SetSizer(v_sizer)

    def onLogin(self, event):
        login = self.username_text.GetValue()
        password = self.password_text.GetValue()
        user = db_manager.UsersModification()
        if user.onLogin(login, password):
            self.Destroy()
            frame = MainFrame(None, 'CRM', 1)
            frame.Maximize(True)
            frame.Show()
        else:
            wx.MessageBox('You have not access', "Error", wx.OK | wx.ICON_ERROR)

    def onQuit(self, event):
        self.Destroy()


app = wx.App()
frame = LoginWindow(None, 'CRM')
frame.Show()
app.MainLoop()
