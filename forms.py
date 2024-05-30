import wx
import db_manager
from random import randint

class ClientAddForm(wx.Dialog):
    def __init__(self, parent, title):
        super().__init__(parent, title=title, size=(740, 460))

        self.SetFont(
            wx.Font(12, wx.FONTFAMILY_DEFAULT, wx.FONTSTYLE_NORMAL, wx.FONTWEIGHT_NORMAL, False, wx.EmptyString))

        bSizer2 = wx.BoxSizer(wx.VERTICAL)

        gbSizer1 = wx.GridBagSizer(10, 10)
        gbSizer1.SetFlexibleDirection(wx.BOTH)
        gbSizer1.SetNonFlexibleGrowMode(wx.FLEX_GROWMODE_SPECIFIED)

        self.first_name_label = wx.StaticText(self, wx.ID_ANY, u"First name", wx.DefaultPosition, wx.DefaultSize, 0)
        self.first_name_label.Wrap(-1)

        gbSizer1.Add(self.first_name_label, wx.GBPosition(1, 1), wx.GBSpan(1, 1), wx.ALL, 10)

        self.first_name_text = wx.TextCtrl(self, wx.ID_ANY, wx.EmptyString, wx.DefaultPosition, wx.DefaultSize, 0)
        self.first_name_text.SetMinSize(wx.Size(200, -1))

        gbSizer1.Add(self.first_name_text, wx.GBPosition(1, 2), wx.GBSpan(1, 1), wx.ALL, 10)

        self.last_name_label = wx.StaticText(self, wx.ID_ANY, u"Last name", wx.DefaultPosition, wx.DefaultSize, 0)
        self.last_name_label.Wrap(-1)

        gbSizer1.Add(self.last_name_label, wx.GBPosition(1, 3), wx.GBSpan(1, 1), wx.ALL, 10)

        self.last_name_text = wx.TextCtrl(self, wx.ID_ANY, wx.EmptyString, wx.DefaultPosition, wx.DefaultSize, 0)
        self.last_name_text.SetMinSize(wx.Size(200, -1))

        gbSizer1.Add(self.last_name_text, wx.GBPosition(1, 4), wx.GBSpan(1, 1), wx.ALL, 10)

        self.email_label = wx.StaticText(self, wx.ID_ANY, u"Email", wx.DefaultPosition, wx.DefaultSize, 0)
        self.email_label.Wrap(-1)

        gbSizer1.Add(self.email_label, wx.GBPosition(2, 1), wx.GBSpan(1, 1), wx.ALL, 10)

        self.email_text = wx.TextCtrl(self, wx.ID_ANY, wx.EmptyString, wx.DefaultPosition, wx.DefaultSize, 0)
        self.email_text.SetMinSize(wx.Size(200, -1))

        gbSizer1.Add(self.email_text, wx.GBPosition(2, 2), wx.GBSpan(1, 1), wx.ALL, 10)

        self.phone_label = wx.StaticText(self, wx.ID_ANY, u"Phone", wx.DefaultPosition, wx.DefaultSize, 0)
        self.phone_label.Wrap(-1)

        gbSizer1.Add(self.phone_label, wx.GBPosition(2, 3), wx.GBSpan(1, 1), wx.ALL, 10)

        self.phone_text = wx.TextCtrl(self, wx.ID_ANY, wx.EmptyString, wx.DefaultPosition, wx.DefaultSize, 0)
        self.phone_text.SetMinSize(wx.Size(200, -1))

        gbSizer1.Add(self.phone_text, wx.GBPosition(2, 4), wx.GBSpan(1, 1), wx.ALL, 10)

        self.username_label = wx.StaticText(self, wx.ID_ANY, u"Username", wx.DefaultPosition, wx.DefaultSize, 0)
        self.username_label.Wrap(-1)

        gbSizer1.Add(self.username_label, wx.GBPosition(3, 1), wx.GBSpan(1, 1), wx.ALL, 10)

        self.username_text = wx.TextCtrl(self, wx.ID_ANY, wx.EmptyString, wx.DefaultPosition, wx.DefaultSize, 0)
        self.username_text.SetMinSize(wx.Size(200, -1))

        gbSizer1.Add(self.username_text, wx.GBPosition(3, 2), wx.GBSpan(1, 1), wx.ALL, 5)

        self.address_label = wx.StaticText(self, wx.ID_ANY, u"Address", wx.DefaultPosition, wx.DefaultSize, 0)
        self.address_label.Wrap(-1)

        gbSizer1.Add(self.address_label, wx.GBPosition(4, 1), wx.GBSpan(1, 1), wx.ALL, 10)

        self.address_text = wx.TextCtrl(self, wx.ID_ANY, wx.EmptyString, wx.DefaultPosition, wx.DefaultSize,
                                        wx.TE_MULTILINE | wx.TE_NO_VSCROLL)
        gbSizer1.Add(self.address_text, wx.GBPosition(5, 1), wx.GBSpan(4, 5), wx.ALL | wx.EXPAND, 10)

        bSizer2.Add(gbSizer1, 1, wx.EXPAND, 10)

        bSizer4 = wx.BoxSizer(wx.HORIZONTAL)

        self.save_button = wx.Button(self, wx.ID_ANY, u"Save", wx.DefaultPosition, wx.DefaultSize, 0)
        bSizer4.Add(self.save_button, 0, wx.ALL, 20)

        self.cancel_button = wx.Button(self, wx.ID_ANY, u"Cancel", wx.DefaultPosition, wx.DefaultSize, 0)
        bSizer4.Add(self.cancel_button, 0, wx.ALL, 20)

        bSizer2.Add(bSizer4, 1, wx.ALIGN_CENTER, 5)

        self.SetSizer(bSizer2)
        self.Layout()

        self.Centre(wx.BOTH)

        # Connect Events
        self.save_button.Bind(wx.EVT_BUTTON, self.on_save_button)
        self.cancel_button.Bind(wx.EVT_BUTTON, self.onQuit)

    def on_save_button(self, event):
        # Retrieve the input values
        first_name = self.first_name_text.GetValue()
        last_name = self.last_name_text.GetValue()
        phone = self.phone_text.GetValue()
        address = self.address_text.GetValue()
        email = self.email_text.GetValue()
        username = self.username_text.GetValue()
        user = db_manager.UsersModification()
        user.save((first_name, last_name, phone, address, email, 2, self.get_password(), username))
        self.Close()

    def onQuit(self, event):
        self.Destroy()

    def get_password(self):
        return ''.join([str(randint(0,9)) for n in range(6)])


class DealAddForm(wx.Dialog):
    def __init__(self, parent, title):
        super().__init__(parent, title=title, size=(630, 480))
        self.parent = parent

        bSizer2 = wx.BoxSizer(wx.VERTICAL)

        gbSizer1 = wx.GridBagSizer(10, 10)
        gbSizer1.SetFlexibleDirection(wx.BOTH)
        gbSizer1.SetNonFlexibleGrowMode(wx.FLEX_GROWMODE_SPECIFIED)

        self.title_label = wx.StaticText(self, wx.ID_ANY, u"Title", wx.DefaultPosition, wx.DefaultSize, 0)
        self.title_label.Wrap(-1)

        gbSizer1.Add(self.title_label, wx.GBPosition(0, 0), wx.GBSpan(1, 1), wx.ALIGN_CENTER, 10)

        self.title_text = wx.TextCtrl(self, wx.ID_ANY, wx.EmptyString, wx.DefaultPosition, wx.Size(-1, -1), 0)
        self.title_text.SetMaxLength(300)
        self.title_text.SetMinSize(wx.Size(200, -1))

        gbSizer1.Add(self.title_text, wx.GBPosition(0, 1), wx.GBSpan(1, 1), wx.ALIGN_CENTER | wx.ALL, 5)

        self.client_label = wx.StaticText(self, wx.ID_ANY, u"Client", wx.DefaultPosition, wx.DefaultSize, 0)
        self.client_label.Wrap(-1)

        gbSizer1.Add(self.client_label, wx.GBPosition(0, 2), wx.GBSpan(1, 1), wx.ALL | wx.EXPAND, 20)

        usr_data = db_manager.UsersModification()
        users = usr_data.get_items_list(fields=['id', 'name', 'last_name'], order_by=('id', 'asc'))

        client_textChoices = [f'{c[1]} {c[2]} - {c[0]}' for c in users]
        self.client_text = wx.ComboBox(self, wx.ID_ANY, wx.EmptyString, wx.DefaultPosition, wx.DefaultSize,
                                       client_textChoices, 0)
        self.client_text.SetMinSize(wx.Size(200, -1))

        gbSizer1.Add(self.client_text, wx.GBPosition(0, 3), wx.GBSpan(1, 1), wx.ALIGN_CENTER | wx.ALL, 5)

        self.desc_label = wx.StaticText(self, wx.ID_ANY, u"Description", wx.DefaultPosition, wx.DefaultSize, 0)
        self.desc_label.Wrap(-1)

        gbSizer1.Add(self.desc_label, wx.GBPosition(2, 0), wx.GBSpan(1, 1), wx.ALL, 10)

        self.desc_text = wx.TextCtrl(self, wx.ID_ANY, wx.EmptyString, wx.DefaultPosition, wx.DefaultSize,
                                     wx.TE_MULTILINE | wx.TE_NO_VSCROLL)
        gbSizer1.Add(self.desc_text, wx.GBPosition(3, 0), wx.GBSpan(4, 5), wx.ALL | wx.EXPAND, 10)

        self.comment_label = wx.StaticText(self, wx.ID_ANY, u"Comment", wx.DefaultPosition, wx.DefaultSize, 0)
        self.comment_label.Wrap(-1)

        gbSizer1.Add(self.comment_label, wx.GBPosition(7, 0), wx.GBSpan(1, 1), wx.ALL, 10)

        self.comment_text = wx.TextCtrl(self, wx.ID_ANY, wx.EmptyString, wx.DefaultPosition, wx.DefaultSize,
                                        wx.TE_MULTILINE | wx.TE_NO_VSCROLL)
        gbSizer1.Add(self.comment_text, wx.GBPosition(8, 0), wx.GBSpan(4, 5), wx.ALL | wx.EXPAND, 10)

        bSizer2.Add(gbSizer1, 1, wx.EXPAND, 10)

        bSizer4 = wx.BoxSizer(wx.HORIZONTAL)

        self.save_button = wx.Button(self, wx.ID_ANY, u"Save", wx.DefaultPosition, wx.DefaultSize, 0)
        bSizer4.Add(self.save_button, 0, wx.ALL, 20)

        self.cancel_button = wx.Button(self, wx.ID_ANY, u"Cancel", wx.DefaultPosition, wx.DefaultSize, 0)
        bSizer4.Add(self.cancel_button, 0, wx.ALL, 20)

        bSizer2.Add(bSizer4, 1, wx.ALIGN_CENTER, 5)

        self.SetSizer(bSizer2)
        self.Layout()

        self.Centre(wx.BOTH)

        # Connect Events
        self.save_button.Bind(wx.EVT_BUTTON, self.on_save_button)
        self.cancel_button.Bind(wx.EVT_BUTTON, self.onQuit)

    def on_save_button(self, event):
        # Retrieve the input values
        description = self.desc_text.GetValue()
        client = self.client_text.GetValue().split('- ')[-1]
        deal = db_manager.DealsModification()
        deal.save((description, int(client), self.parent.manager, 1))

        # Close the popup
        self.Close()

    def onQuit(self, event):
        self.Destroy()


class ClientEditForm(wx.Dialog):
    def __init__(self, parent, user_id):
        super().__init__(parent, title="Edit Client", size=(720, 450))
        self.user_id = user_id
        self.user = db_manager.UsersModification()
        self.user_info = self.user.get_item(input_id=user_id)

        self.SetSizeHints(wx.DefaultSize, wx.DefaultSize)
        self.SetFont(
            wx.Font(12, wx.FONTFAMILY_DEFAULT, wx.FONTSTYLE_NORMAL, wx.FONTWEIGHT_NORMAL, False, wx.EmptyString))

        bSizer2 = wx.BoxSizer(wx.VERTICAL)

        gbSizer1 = wx.GridBagSizer(10, 10)
        gbSizer1.SetFlexibleDirection(wx.BOTH)
        gbSizer1.SetNonFlexibleGrowMode(wx.FLEX_GROWMODE_SPECIFIED)

        self.first_name_label = wx.StaticText(self, wx.ID_ANY, u"First name", wx.DefaultPosition, wx.DefaultSize, 0)
        self.first_name_label.Wrap(-1)

        gbSizer1.Add(self.first_name_label, wx.GBPosition(1, 1), wx.GBSpan(1, 1), wx.ALL, 10)

        self.first_name_text = wx.TextCtrl(self, wx.ID_ANY, wx.EmptyString, wx.DefaultPosition, wx.DefaultSize, 0)
        self.first_name_text.SetMinSize(wx.Size(200, -1))

        gbSizer1.Add(self.first_name_text, wx.GBPosition(1, 2), wx.GBSpan(1, 1), wx.ALL, 10)

        self.last_name_label = wx.StaticText(self, wx.ID_ANY, u"Last name", wx.DefaultPosition, wx.DefaultSize, 0)
        self.last_name_label.Wrap(-1)

        gbSizer1.Add(self.last_name_label, wx.GBPosition(1, 3), wx.GBSpan(1, 1), wx.ALL, 10)

        self.last_name_text = wx.TextCtrl(self, wx.ID_ANY, wx.EmptyString, wx.DefaultPosition, wx.DefaultSize, 0)
        self.last_name_text.SetMinSize(wx.Size(200, -1))

        gbSizer1.Add(self.last_name_text, wx.GBPosition(1, 4), wx.GBSpan(1, 1), wx.ALL, 10)

        self.email_label = wx.StaticText(self, wx.ID_ANY, u"Email", wx.DefaultPosition, wx.DefaultSize, 0)
        self.email_label.Wrap(-1)

        gbSizer1.Add(self.email_label, wx.GBPosition(2, 1), wx.GBSpan(1, 1), wx.ALL, 10)

        self.email_text = wx.TextCtrl(self, wx.ID_ANY, wx.EmptyString, wx.DefaultPosition, wx.DefaultSize, 0)
        self.email_text.SetMinSize(wx.Size(200, -1))

        gbSizer1.Add(self.email_text, wx.GBPosition(2, 2), wx.GBSpan(1, 1), wx.ALL, 10)

        self.phone_label = wx.StaticText(self, wx.ID_ANY, u"Phone", wx.DefaultPosition, wx.DefaultSize, 0)
        self.phone_label.Wrap(-1)

        gbSizer1.Add(self.phone_label, wx.GBPosition(2, 3), wx.GBSpan(1, 1), wx.ALL, 10)

        self.phone_text = wx.TextCtrl(self, wx.ID_ANY, wx.EmptyString, wx.DefaultPosition, wx.DefaultSize, 0)
        self.phone_text.SetMinSize(wx.Size(200, -1))

        gbSizer1.Add(self.phone_text, wx.GBPosition(2, 4), wx.GBSpan(1, 1), wx.ALL, 10)

        self.address_label = wx.StaticText(self, wx.ID_ANY, u"Address", wx.DefaultPosition, wx.DefaultSize, 0)
        self.address_label.Wrap(-1)

        gbSizer1.Add(self.address_label, wx.GBPosition(3, 1), wx.GBSpan(1, 1), wx.ALL, 10)

        self.address_text = wx.TextCtrl(self, wx.ID_ANY, wx.EmptyString, wx.DefaultPosition, wx.DefaultSize,
                                        wx.TE_MULTILINE | wx.TE_NO_VSCROLL)
        gbSizer1.Add(self.address_text, wx.GBPosition(4, 1), wx.GBSpan(4, 5), wx.ALL | wx.EXPAND, 10)

        bSizer2.Add(gbSizer1, 1, wx.EXPAND, 10)

        bSizer4 = wx.BoxSizer(wx.HORIZONTAL)

        self.save_button = wx.Button(self, wx.ID_ANY, u"Save", wx.DefaultPosition, wx.DefaultSize, 0)
        bSizer4.Add(self.save_button, 0, wx.ALL, 20)

        self.cancel_button = wx.Button(self, wx.ID_ANY, u"Cancel", wx.DefaultPosition, wx.DefaultSize, 0)
        bSizer4.Add(self.cancel_button, 0, wx.ALL, 20)

        bSizer2.Add(bSizer4, 1, wx.ALIGN_CENTER, 5)

        self.SetSizer(bSizer2)
        self.Layout()

        self.Centre(wx.BOTH)

        # Load current values
        self.first_name_text.SetValue(self.user_info[1])
        self.last_name_text.SetValue(self.user_info[2])
        self.phone_text.SetValue(self.user_info[3])
        self.address_text.SetValue(self.user_info[4])
        self.email_text.SetValue(self.user_info[5])

        # Connect Events
        self.save_button.Bind(wx.EVT_BUTTON, self.on_save_button)
        self.cancel_button.Bind(wx.EVT_BUTTON, self.onQuit)

    def on_save_button(self, event):
        updated_user_info = (
            self.user_info[0],
            self.first_name_text.GetValue(),
            self.last_name_text.GetValue(),
            self.phone_text.GetValue(),
            self.address_text.GetValue(),
            self.email_text.GetValue(),
            self.user_info[6],
            self.user_info[7],
            self.user_info[8],
        )
        try:
            self.user.update(updated_user_info[1:], self.user_id)
            wx.MessageBox("Client was successfully updated!", "Success", wx.OK | wx.ICON_INFORMATION)
        # self.clients[selected_item - 1] = updated_client_info
        # self.list_ctrl.RefreshItem(selected_item - 1)
        except Exception:
            wx.MessageBox(Exception.__cause__, "Error", wx.OK | wx.ICON_ERROR)
        finally:
            self.Destroy()
        return updated_user_info

    def onQuit(self):
        self.Destroy()



