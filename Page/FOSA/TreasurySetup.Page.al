page 50107 "Treasury Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Treasury Setup";
    ;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Treasury Transaction Nos."; Rec."Treasury Transaction Nos.")
                {
                    ApplicationArea = All;
                }
                field("Treasury Request Nos."; Rec."Treasury Request Nos.")
                {
                    ApplicationArea = All;
                }
                field("Treasury Return Bank Nos."; Rec."Treasury Return Bank Nos.")
                {
                    ApplicationArea = All;
                }
            }
            group(Posting)
            {
                field("Treasury Template Name"; Rec."Treasury Template Name")
                {
                    ApplicationArea = All;
                }
                field("Treasury Batch Name"; Rec."Treasury Batch Name")
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