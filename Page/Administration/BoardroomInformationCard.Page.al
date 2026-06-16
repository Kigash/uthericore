page 50984 "Boardroom Information Card"
{
    // version TL2.0

    PageType = Card;
    SourceTable = "Boardroom Detail";

    layout
    {
        area(content)
        {
            group("Boardroom Info")
            {
                field("Boardroom No"; Rec."Boardroom No")
                {
                    ApplicationArea = All;

                }
                field("Boardroom Name"; Rec."Boardroom Name")
                {
                    ApplicationArea = All;

                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;

                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;

                }
                field(Save; Rec.Register)
                {
                    ApplicationArea = All;

                }
                field("Equipment Available"; Rec."Equipment Available")
                {
                    ApplicationArea = All;

                }
                field("Maximum Capacity"; Rec."Maximum Capacity")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Register)
            {
                ApplicationArea = all;
                Caption = 'Save Boardroom Details';
                Image = CreateWhseLoc;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    RegistryManagement.SaveBoardroomDetails(Rec);
                    CurrPage.CLOSE;
                end;
            }
        }
    }

    var
        RegistryManagement: Codeunit "Registry Management2";
}

