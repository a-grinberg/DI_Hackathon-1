# -*- coding: utf-8 -*-
import wx
import wx.xrc
import wx.html

import db_manager
from db_manager import DbConnection


class DealDetail(wx.Panel):

    def __init__(self, parent, id=wx.ID_ANY, pos=wx.DefaultPosition, size=wx.Size(1187, 760), style=wx.TAB_TRAVERSAL,
                 name=wx.EmptyString):
        wx.Panel.__init__(self, parent, id=id, pos=pos, size=size, style=style, name=name)
        self.parent = parent
        self.status_choices = {s[-1]: s[0] for s in DbConnection.execute_select('SELECT * from status')}

        gbSizer2 = wx.GridBagSizer(0, 0)
        gbSizer2.SetFlexibleDirection(wx.BOTH)
        gbSizer2.SetNonFlexibleGrowMode(wx.FLEX_GROWMODE_SPECIFIED)

        # Order details
        self.order_label = wx.StaticText(self, wx.ID_ANY, u"ORDER", wx.DefaultPosition, wx.DefaultSize, 0)
        self.order_label.Wrap(-1)

        self.order_label.SetFont(
            wx.Font(14, wx.FONTFAMILY_DEFAULT, wx.FONTSTYLE_NORMAL, wx.FONTWEIGHT_NORMAL, False, wx.EmptyString))

        gbSizer2.Add(self.order_label, wx.GBPosition(1, 1), wx.GBSpan(1, 1), wx.ALIGN_CENTER | wx.ALL, 10)

        self.order_id_text = wx.StaticText(self, wx.ID_ANY, u"order_id", wx.DefaultPosition, wx.DefaultSize, 0)
        self.order_id_text.Wrap(-1)

        self.order_id_text.SetFont(
            wx.Font(14, wx.FONTFAMILY_DEFAULT, wx.FONTSTYLE_NORMAL, wx.FONTWEIGHT_BOLD, False, wx.EmptyString))

        gbSizer2.Add(self.order_id_text, wx.GBPosition(1, 2), wx.GBSpan(1, 1), wx.ALIGN_CENTER | wx.ALL, 10)

        self.status_label = wx.StaticText(self, wx.ID_ANY, u"status", wx.DefaultPosition, wx.DefaultSize, 0)
        self.status_label.Wrap(-1)

        self.status_label.SetFont(
            wx.Font(14, wx.FONTFAMILY_DEFAULT, wx.FONTSTYLE_ITALIC, wx.FONTWEIGHT_NORMAL, False, wx.EmptyString))

        gbSizer2.Add(self.status_label, wx.GBPosition(1, 3), wx.GBSpan(1, 1),
                     wx.ALIGN_CENTER_VERTICAL | wx.ALIGN_LEFT | wx.ALL, 10)

        bSizer7 = wx.BoxSizer(wx.HORIZONTAL)
        self.created_label = wx.StaticText(self, wx.ID_ANY, u"Created: ", wx.DefaultPosition, wx.DefaultSize, 0)
        self.created_label.Wrap(-1)

        bSizer7.Add(self.created_label, 0, wx.ALIGN_CENTER | wx.ALL, 5)

        self.created_text = wx.StaticText(self, wx.ID_ANY, u"created", wx.DefaultPosition, wx.DefaultSize, 0)
        self.created_text.Wrap(-1)
        self.created_text.SetMinSize(wx.Size(150, -1))

        bSizer7.Add(self.created_text, 0, wx.ALIGN_CENTER | wx.ALL, 10)

        self.updated_label = wx.StaticText(self, wx.ID_ANY, u"Updated:", wx.DefaultPosition, wx.DefaultSize, 0)
        self.updated_label.Wrap(-1)

        bSizer7.Add(self.updated_label, 0, wx.ALIGN_CENTER | wx.ALL, 5)

        self.updated_text = wx.StaticText(self, wx.ID_ANY, u"updated", wx.DefaultPosition, wx.DefaultSize, 0)
        self.updated_text.Wrap(-1)
        self.updated_text.SetMinSize(wx.Size(150, -1))

        bSizer7.Add(self.updated_text, 0, wx.ALIGN_CENTER | wx.ALL, 10)

        self.manager_label = wx.StaticText(self, wx.ID_ANY, u"Manager:", wx.DefaultPosition, wx.DefaultSize, 0)
        self.manager_label.Wrap(-1)

        bSizer7.Add(self.manager_label, 0, wx.ALIGN_CENTER | wx.ALL, 10)

        self.manager_text = wx.StaticText(self, wx.ID_ANY, u"manager", wx.DefaultPosition, wx.DefaultSize, 0)
        self.manager_text.Wrap(-1)
        self.manager_text.SetMinSize(wx.Size(200, -1))

        bSizer7.Add(self.manager_text, 0, wx.ALIGN_CENTER | wx.ALL, 10)

        self.status_list = wx.Choice(self, wx.ID_ANY, wx.DefaultPosition, wx.DefaultSize, list(self.status_choices.keys()), 0)
        self.status_list.SetSelection(0)
        self.status_list.SetMinSize(wx.Size(150, -1))

        bSizer7.Add(self.status_list, 0, wx.ALIGN_CENTER | wx.ALL, 5)

        self.update_status_button = wx.Button(self, wx.ID_ANY, u"Update status", wx.DefaultPosition, wx.DefaultSize, 0)
        self.update_status_button.SetFont(
            wx.Font(12, wx.FONTFAMILY_DEFAULT, wx.FONTSTYLE_NORMAL, wx.FONTWEIGHT_NORMAL, False, wx.EmptyString))

        bSizer7.Add(self.update_status_button, 0, wx.ALL, 10)

        gbSizer2.Add(bSizer7, wx.GBPosition(2, 1), wx.GBSpan(1, 3), wx.ALL, 10)

        # Customer details

        sbSizer1 = wx.StaticBoxSizer(wx.StaticBox(self, wx.ID_ANY, u"Contact info"), wx.VERTICAL)

        gSizer2 = wx.GridSizer(4, 4, 0, 0)

        self.name_label = wx.StaticText(sbSizer1.GetStaticBox(), wx.ID_ANY, u"Customer:", wx.DefaultPosition,
                                        wx.DefaultSize, 0)
        self.name_label.Wrap(-1)

        self.name_label.SetFont(
            wx.Font(12, wx.FONTFAMILY_DEFAULT, wx.FONTSTYLE_NORMAL, wx.FONTWEIGHT_NORMAL, False, wx.EmptyString))

        gSizer2.Add(self.name_label, 0, wx.ALL, 10)

        self.name_text = wx.StaticText(sbSizer1.GetStaticBox(), wx.ID_ANY, u"customer_name", wx.DefaultPosition,
                                       wx.DefaultSize, 0)
        self.name_text.Wrap(-1)

        self.name_text.SetFont(
            wx.Font(12, wx.FONTFAMILY_DEFAULT, wx.FONTSTYLE_NORMAL, wx.FONTWEIGHT_NORMAL, False, wx.EmptyString))

        gSizer2.Add(self.name_text, 0, wx.ALL, 10)

        self.phone_label = wx.StaticText(sbSizer1.GetStaticBox(), wx.ID_ANY, u"Phone:", wx.DefaultPosition,
                                         wx.DefaultSize, 0)
        self.phone_label.Wrap(-1)

        self.phone_label.SetFont(
            wx.Font(12, wx.FONTFAMILY_DEFAULT, wx.FONTSTYLE_NORMAL, wx.FONTWEIGHT_NORMAL, False, wx.EmptyString))

        gSizer2.Add(self.phone_label, 0, wx.ALL, 10)

        self.phone_text = wx.StaticText(sbSizer1.GetStaticBox(), wx.ID_ANY, u"phone", wx.DefaultPosition,
                                        wx.DefaultSize, 0)
        self.phone_text.Wrap(-1)

        self.phone_text.SetFont(
            wx.Font(12, wx.FONTFAMILY_DEFAULT, wx.FONTSTYLE_NORMAL, wx.FONTWEIGHT_NORMAL, False, wx.EmptyString))

        gSizer2.Add(self.phone_text, 0, wx.ALIGN_LEFT | wx.ALL, 10)

        self.email_label = wx.StaticText(sbSizer1.GetStaticBox(), wx.ID_ANY, u"Email:", wx.DefaultPosition,
                                         wx.DefaultSize, 0)
        self.email_label.Wrap(-1)

        self.email_label.SetFont(
            wx.Font(12, wx.FONTFAMILY_DEFAULT, wx.FONTSTYLE_NORMAL, wx.FONTWEIGHT_NORMAL, False, wx.EmptyString))

        gSizer2.Add(self.email_label, 0, wx.ALL, 10)

        self.email_text = wx.StaticText(sbSizer1.GetStaticBox(), wx.ID_ANY, u"email", wx.DefaultPosition,
                                        wx.DefaultSize, 0)
        self.email_text.Wrap(-1)

        self.email_text.SetFont(
            wx.Font(12, wx.FONTFAMILY_DEFAULT, wx.FONTSTYLE_NORMAL, wx.FONTWEIGHT_NORMAL, False, wx.EmptyString))

        gSizer2.Add(self.email_text, 0, wx.ALL, 10)

        self.adress_label = wx.StaticText(sbSizer1.GetStaticBox(), wx.ID_ANY, u"Address:", wx.DefaultPosition,
                                          wx.DefaultSize, 0)
        self.adress_label.Wrap(-1)

        self.adress_label.SetFont(
            wx.Font(12, wx.FONTFAMILY_DEFAULT, wx.FONTSTYLE_NORMAL, wx.FONTWEIGHT_NORMAL, False, wx.EmptyString))

        gSizer2.Add(self.adress_label, 0, wx.ALL, 10)

        self.address_text = wx.StaticText(sbSizer1.GetStaticBox(), wx.ID_ANY, u"address", wx.DefaultPosition,
                                          wx.DefaultSize, 0)
        self.address_text.Wrap(-1)

        self.address_text.SetFont(
            wx.Font(12, wx.FONTFAMILY_DEFAULT, wx.FONTSTYLE_NORMAL, wx.FONTWEIGHT_NORMAL, False, wx.EmptyString))
        self.address_text.SetMinSize(wx.Size(200, -1))

        gSizer2.Add(self.address_text, 0, wx.ALL, 10)

        sbSizer1.Add(gSizer2, 1, wx.EXPAND, 5)

        gbSizer2.Add(sbSizer1, wx.GBPosition(3, 1), wx.GBSpan(1, 3), wx.EXPAND, 5)

        self.desc_text = wx.StaticText(self, wx.ID_ANY, u"Description", wx.DefaultPosition, wx.Size(800, -1), 0)
        self.desc_text.Wrap(-1)
        self.desc_text.SetMaxSize(wx.Size(800, -1))

        gbSizer2.Add(self.desc_text, wx.GBPosition(5, 1), wx.GBSpan(5, 4), wx.ALL, 5)

        self.m_staticline2 = wx.StaticLine(self, wx.ID_ANY, wx.DefaultPosition, wx.DefaultSize, wx.LI_VERTICAL)
        gbSizer2.Add(self.m_staticline2, wx.GBPosition(1, 6), wx.GBSpan(6, 1), wx.EXPAND | wx.ALL, 5)

        bSizer6 = wx.BoxSizer(wx.VERTICAL)

        bSizer8 = wx.BoxSizer(wx.VERTICAL)

        self.comments_text = wx.StaticText(self, wx.ID_ANY, u"comments_text", wx.DefaultPosition, wx.DefaultSize, 0)
        self.comments_text.Wrap(-1)

        self.comments_text.SetMinSize(wx.Size(240, 500))

        bSizer8.Add(self.comments_text, 0, wx.ALL, 10)

        bSizer6.Add(bSizer8, 1, wx.EXPAND, 5)

        self.m_staticText27 = wx.StaticText(self, wx.ID_ANY, u"Add comment", wx.DefaultPosition, wx.DefaultSize, 0)
        self.m_staticText27.Wrap(-1)

        bSizer6.Add(self.m_staticText27, 0, wx.ALL, 5)

        self.add_comment_txt = wx.TextCtrl(self, wx.ID_ANY, wx.EmptyString, wx.DefaultPosition, wx.Size(-1, 50),
                                           wx.TE_MULTILINE | wx.TE_NO_VSCROLL)
        self.add_comment_txt.SetMinSize(wx.Size(240, 100))

        bSizer6.Add(self.add_comment_txt, 0, wx.EXPAND, 5)

        self.add_comment_button = wx.Button(self, wx.ID_ANY, u"Add comment", wx.DefaultPosition, wx.DefaultSize, 0)
        self.add_comment_button.SetFont(
            wx.Font(12, wx.FONTFAMILY_DEFAULT, wx.FONTSTYLE_NORMAL, wx.FONTWEIGHT_NORMAL, False, wx.EmptyString))

        bSizer6.Add(self.add_comment_button, 0, wx.ALL, 5)

        gbSizer2.Add(bSizer6, wx.GBPosition(1, 7), wx.GBSpan(7, 1), wx.EXPAND, 5)

        self.SetSizer(gbSizer2)
        self.Layout()

        # Connect Events
        self.update_status_button.Bind(wx.EVT_BUTTON, self.on_change_status)
        self.add_comment_button.Bind(wx.EVT_BUTTON, self.on_add_comment)

    def get_comments(self, value):
        self.comments = value

    def on_change_status(self, event):
        deal = db_manager.DealsModification()
        try:
            deal.status_update((self.status_list.GetSelection()+1, self.order_id_text.GetLabelText()))
            wx.MessageBox("Status was successfully updated!", "Success", wx.OK | wx.ICON_INFORMATION)
        except:
            wx.MessageBox('Something is wrong.', "Error", wx.OK | wx.ICON_ERROR)
    def on_add_comment(self, event):
        comment = db_manager.ComentsModification()
        comment.save((self.order_id_text.GetLabelText(), self.parent.Parent.Parent.manager, self.add_comment_txt.GetValue()))
        self.add_comment_txt.Clear()
        self.Show()
