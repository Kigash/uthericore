page 50109 "ATM Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "ATM Setup";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("ATM Application Nos."; Rec."ATM Application Nos.")
                {
                    ApplicationArea = All;
                }
                field("ATM Collection Nos."; Rec."ATM Collection Nos.")
                {
                    ApplicationArea = All;
                }
                field("ATM Activation Nos."; Rec."ATM Activation Nos.")
                {
                    ApplicationArea = All;
                }
            }
            group(Posting)
            {
                field("ATM Journal Template"; Rec."ATM Journal Template")
                {
                    ApplicationArea = All;
                }
                field("ATM Batch Name"; Rec."ATM Batch Name")
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
            /* action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            } */
        }
    }

    var
        myInt: Integer;
}