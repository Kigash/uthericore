page 50231 "Member Exit Subform"
{
    // version TL2.0

    Editable = false;
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = "Member Exit Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account Category"; Rec."Account Category")
                {
                    ApplicationArea = All;
                }
                field("Account Type"; Rec."Account Type")
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
                field("Account Balance"; Rec."Account Balance")
                {
                    ApplicationArea = All;
                }
                field("Account Ownership"; Rec."Account Ownership")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Boost Shares")
            {
                Image = Add;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    BOSAManagement: Codeunit "BOSA Management";
                    MemberExitLine: Record "Member Exit Line";
                begin
                    CurrPage.SETSELECTIONFILTER(MemberExitLine);
                    BOSAManagement.BoostShares(MemberExitLine);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.FILTERGROUP(2);
        Rec.FILTERGROUP(0);
    end;
}

