page 54389 "Bulk SMS To Members Sent"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
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
                    ApplicationArea = All;
                    Caption = 'SMS Text';
                    Editable = PageEditable;
                    MultiLine = true;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
            }
            part(Control6; "Bulk SMS To Members Lines")
            {
                Editable = PageEditable;
                ApplicationArea = All;
                SubPageLink = "Document No" = FIELD("No.");
                SubPageView = WHERE("Owner Phone No" = FILTER(<> ''), Select = CONST(true));
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

    var
        GlobalM: Codeunit "Global Management";
        BulkSMSLine: Record "Bulk SMS Line";
        //SendSms : Codeunit "CheckOff Management";
        SendSmsVisible: Boolean;
        PageEditable: Boolean;
        SMSText: Text;
}

