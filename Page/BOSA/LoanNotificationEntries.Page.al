page 59300 "Loan Notification Entries"
{
    // version TL2.0

    Editable = false;
    PageType = List;
    SourceTable = "Loan Notification Entry";
    UsageCategory = Lists;
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
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field(PhoneNo; PhoneNo)
                {
                    ApplicationArea = All;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("Notification Sent"; SMSTemplate)
                {
                    ApplicationArea = All;
                }
                field("Notification Date"; Rec."Notification Date")
                {
                    ApplicationArea = All;
                }
                field("Notification Time"; Rec."Notification Time")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action(Print)
            {
                Image = BankAccountStatement;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    //REPORT.RUN(REPORT::"Loan Classification Report",TRUE,FALSE);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        PhoneNo := '';
        SMSTemplate := Rec.GetSMSTemplate;
        Member.Get(Rec."Member No.");
        PhoneNo := Member."Phone No.";
    end;

    var
        SMSTemplate: Text;
        PhoneNo: Code[20];
        Member: Record Member;
}

