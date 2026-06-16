page 50131 "ATM Member Card"
{
    // version TL2.0

    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,History,Approval Request,Category 6,Category 7,Category 8';
    SourceTable = "ATM Member";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Card No."; Rec."Card No.")
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
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                }
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                }
                field("Collection No."; Rec."Collection No.")
                {
                    ApplicationArea = All;
                }
                field("SMS Alert on"; Rec."SMS Alert on")
                {
                    ApplicationArea = All;
                }
                field("E-Mail Alert on"; Rec."E-Mail Alert on")
                {
                    ApplicationArea = All;
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Ledger Entries")
            {
                Image = LedgerEntries;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page 50140;
                RunPageLink = "Card No." = FIELD("Card No.");
            }
        }
    }
}

