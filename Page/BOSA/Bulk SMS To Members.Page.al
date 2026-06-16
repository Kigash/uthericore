page 54385 "Bulk SMS To Members"
{
    Editable = true;
    PageType = Card;
    SourceTable = "Bulk SMS To Members";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("SMS Date"; Rec."SMS Date")
                {
                    ApplicationArea = All;
                }
                field(SMSText; SMSText)
                {
                    Caption = 'SMS Text';
                    MultiLine = true;
                    Visible = true;
                    ApplicationArea = All;
                    trigger OnValidate();
                    begin
                        Rec.TestField("SMS Date");
                        Rec.SetSMSTemplate(SMSText);
                    end;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
            }
            part(Control6; "Bulk SMS To Members Lines")
            {
                ApplicationArea = All;
                Editable = PageEditable;
                SubPageLink = "Document No" = FIELD("No.");
                SubPageView = WHERE("Owner Phone No" = FILTER(<> ''));
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(ActionGroup9)
            {
                action("Send SMS")
                {
                    Image = SendToMultiple;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Visible = SendSmsVisible;
                    ApplicationArea = All;
                    trigger OnAction();
                    begin
                        if CONFIRM('Are you sure you want to send SMS notification to the selected members.?') = true then begin
                            BulkSMSLine.RESET;
                            BulkSMSLine.SETRANGE(BulkSMSLine."Document No", Rec."No.");
                            BulkSMSLine.SETRANGE(BulkSMSLine.Select, true);
                            BulkSMSLine.SETRANGE(BulkSMSLine."Sent To Phone No", false);
                            if BulkSMSLine.FINDSET then begin
                                repeat
                                    Clear(BigSMS);
                                    BigSMS.ADDTEXT(SMSText);
                                    SMSEntry."SMS Text".CREATEOUTSTREAM(Ostream);
                                    BigSMS.WRITE(Ostream);

                                    GlobalM.CreateSMSEntry(BulkSMSLine."Owner Phone No", BigSMS, 'BULKSMS');
                                    BulkSMSLine2.RESET;
                                    BulkSMSLine2.SETRANGE(BulkSMSLine2."Owner Phone No", BulkSMSLine."Owner Phone No");
                                    BulkSMSLine2.SETRANGE(BulkSMSLine2."Document No", BulkSMSLine."Document No");
                                    if BulkSMSLine2.FINDSET then begin
                                        repeat
                                            BulkSMSLine2."Sent To Phone No" := true;
                                            BulkSMSLine2.MODIFY;
                                        until BulkSMSLine2.NEXT = 0;
                                    end;
                                until BulkSMSLine.NEXT = 0;
                            end;
                            Rec."SMS Sent" := true;
                            Rec.MODIFY;

                            BulkSMSLine.RESET;
                            BulkSMSLine.SETRANGE(BulkSMSLine."Document No", Rec."No.");
                            BulkSMSLine.SETRANGE(BulkSMSLine.Select, false);
                            if BulkSMSLine.FINDSET then begin
                                BulkSMSLine.DELETEALL;
                            end;
                            Message('SMS Message sent successfuly');
                            exit;
                        end;
                    end;
                }
                action("Select All")
                {
                    Image = SelectEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Visible = SendSmsVisible;
                    ApplicationArea = All;
                    trigger OnAction();
                    begin
                        BulkSMSLine.RESET;
                        BulkSMSLine.SETRANGE(BulkSMSLine."Document No", Rec."No.");
                        if BulkSMSLine.FINDSET then begin
                            repeat
                                BulkSMSLine.Select := true;
                                BulkSMSLine.MODIFY;
                            until BulkSMSLine.NEXT = 0;
                        end;
                    end;
                }
                action("UnSelect All")
                {
                    Image = SelectLineToApply;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Visible = SendSmsVisible;
                    ApplicationArea = All;
                    trigger OnAction();
                    begin
                        BulkSMSLine.RESET;
                        BulkSMSLine.SETRANGE(BulkSMSLine."Document No", Rec."No.");
                        if BulkSMSLine.FINDSET then begin
                            repeat
                                BulkSMSLine.Select := false;
                                BulkSMSLine.MODIFY;
                            until BulkSMSLine.NEXT = 0;
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        SMSText := Rec.GetSMSTemplate;
    end;

    trigger OnOpenPage();
    begin
        if Rec."SMS Sent" = true then begin
            SendSmsVisible := false;
            PageEditable := false;
        end
        else begin
            SendSmsVisible := true;
            PageEditable := true;
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Source Code" := 'BULKSMS';
        Rec.Modify();
    end;

    var
        BulkSMSLine: Record "Bulk SMS Line";
        // SendSms : Codeunit "Member Recipt SMS Notification";
        SendSmsVisible: Boolean;
        PageEditable: Boolean;
        BulkSMSLine2: Record "Bulk SMS Line";
        SMSText: Text;
        SMSEntry: Record "SMS Entry";
        SMSEntry2: Record "SMS Entry";
        EntryNo: Integer;
        BigSMS: BigText;
        Ostream: OutStream;
        GlobalM: Codeunit "Global Management";
}


