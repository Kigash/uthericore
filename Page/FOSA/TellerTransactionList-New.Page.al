page 50062 "Teller Transactions List-New"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Teller Transaction Header";
    SourceTableView = WHERE(Status = FILTER(New), Posted = filter(false));
    CardPageId = 50060;
    layout
    {
        area(Content)
        {
            repeater(Teller)
            {
                field("No."; Rec."No.")
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
                field(Narration; Rec.Narration)
                {
                    ApplicationArea = All;
                }
                field("Total Line  Amount"; Rec."Total Line Amount")
                {
                    ApplicationArea = All;

                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;

                }
                field("Teller User ID"; Rec."Teller User ID")
                {
                    ApplicationArea = All;

                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetFilter("Teller User ID", UserId);
    end;
}