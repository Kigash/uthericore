page 50250 "SMS Entries"
{
    // version TL2.0

    Editable = false;
    PageType = List;
    SourceTable = "SMS Entry";
    UsageCategory = History;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field(SMSText; SMSText)
                {
                    Caption = 'SMS Text';
                    ApplicationArea = All;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Created Time"; Rec."Created Time")
                {
                    ApplicationArea = All;
                }
                field(Sent; Rec.Sent)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Send SMS")
            {
                Image = SendTo;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    if Confirm(SendSMSConfirmMsg, true) then begin
                        if not Rec.Sent then
                            SMSManagement.SendGETSMSRequest(Rec)
                        else
                            Error(SMSAlreadySentMsg);
                    end else
                        exit;
                end;

            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SMSText := Rec.GetSMSTemplate;
        Rec.CalcFields("SMS Text");
    end;

    var
        SMSText: Text;
        SMSManagement: Codeunit "Mobile Banking";
        SendSMSConfirmMsg: Label 'Do you want to send SMS to the selected entry?';
        SMSAlreadySentMsg: Label 'SMS is already sent';
}
