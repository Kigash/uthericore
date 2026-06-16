page 54388 "Bulk SMS To Members Sent List"
{
    CardPageID = "Bulk SMS To Members Sent";
    PageType = List;
    SourceTable = "Bulk SMS To Members";
    SourceTableView = WHERE("SMS Sent" = CONST(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(SMSText; SMSText)
                {
                    ApplicationArea = All;
                    Caption = 'SMS Text';
                    Editable = false;
                }
                field("SMS Date"; Rec."SMS Date")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        SMSText := Rec.GetSMSTemplate;
    end;

    var
        SMSText: Text;
}

